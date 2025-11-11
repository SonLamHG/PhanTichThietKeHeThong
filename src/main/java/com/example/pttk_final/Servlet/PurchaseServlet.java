package com.example.pttk_final.Servlet;

import com.example.pttk_final.DAO.EmployeeDAO;
import com.example.pttk_final.DAO.ProductDAO;
import com.example.pttk_final.DAO.PurchaseDAO;
import com.example.pttk_final.DAO.SupplierDAO;
import com.example.pttk_final.Entity.Employee;
import com.example.pttk_final.Entity.Member;
import com.example.pttk_final.Entity.Product;
import com.example.pttk_final.Entity.PurchaseDetail;
import com.example.pttk_final.Entity.PurchaseInvoice;
import com.example.pttk_final.Entity.Supplier;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "PurchaseServlet", urlPatterns = "/purchase")
public class PurchaseServlet extends HttpServlet {

    private static final String PURCHASE_VIEW = "/view/purchaseProduct.jsp";
    private static final String SUPPLIER_SEARCH_VIEW = "/view/supplierSearch.jsp";
    private static final String PRODUCT_SEARCH_VIEW = "/view/productSearch.jsp";

    private final SupplierDAO supplierDAO = new SupplierDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final PurchaseDAO purchaseDAO = new PurchaseDAO();
    private final EmployeeDAO employeeDAO = new EmployeeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            forwardToSummary(request, response);
            return;
        }

        switch (action) {
            case "supplierSearch":
                preloadSuppliers(request);
                forward(request, response, SUPPLIER_SEARCH_VIEW);
                break;
            case "searchSupplier":
                handleSupplierSearch(request, response);
                break;
            case "selectSupplier":
                handleSelectSupplier(request, response);
                break;
            case "productSearch":
                preloadProducts(request);
                forward(request, response, PRODUCT_SEARCH_VIEW);
                break;
            case "searchProduct":
                handleProductSearch(request, response);
                break;
            default:
                forwardToSummary(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            redirect(request, response, "/purchase");
            return;
        }

        switch (action) {
            case "addProduct":
                handleAddProduct(request, response);
                break;
            case "removeProduct":
                handleRemoveProduct(request, response);
                break;
            case "createInvoice":
                handleCreateInvoice(request, response);
                break;
            case "addSupplier":
                handleAddSupplier(request, response);
                break;
            case "addNewProduct":
                handleAddNewProduct(request, response);
                break;
            default:
                redirect(request, response, "/purchase");
                break;
        }
    }

    private void handleSupplierSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("supplierName");
        List<Supplier> suppliers = supplierDAO.searchSupplier(keyword == null ? "" : keyword.trim());
        request.setAttribute("suppliers", suppliers);
        forward(request, response, SUPPLIER_SEARCH_VIEW);
    }

    private void handleProductSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("productName");
        List<Product> products = productDAO.searchProduct(keyword == null ? "" : keyword.trim());
        request.setAttribute("products", products);
        forward(request, response, PRODUCT_SEARCH_VIEW);
    }

    private void handleSelectSupplier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                Supplier supplier = supplierDAO.getSupplierById(id);
                if (supplier != null) {
                    session.setAttribute("selectedSupplier", supplier);
                    setSuccess(session, "Đã chọn nhà cung cấp " + supplier.getName());
                } else {
                    setError(session, "Không tìm thấy nhà cung cấp đã chọn.");
                }
            } catch (NumberFormatException ex) {
                setError(session, "Mã nhà cung cấp không hợp lệ.");
            }
        }
        redirect(request, response, "/purchase");
    }

    private void handleAddProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String productIdParam = request.getParameter("productId");
        if (productIdParam == null) {
            session.setAttribute("purchaseError", "Thiếu thông tin sản phẩm.");
            redirect(request, response, "/purchase?action=productSearch");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdParam);
            Product product = productDAO.getProductById(productId);
            if (product == null) {
                session.setAttribute("purchaseError", "Không tìm thấy sản phẩm đã chọn.");
                redirect(request, response, "/purchase?action=productSearch");
                return;
            }

            int quantity = parsePositiveInt(request.getParameter("quantity"), 1);
            float unitPrice = parsePositiveFloat(request.getParameter("unitPrice"), product.getUnitPrice());

            List<PurchaseDetail> cart = getOrCreateCart(session);
            boolean existed = false;
            for (PurchaseDetail detail : cart) {
                if (detail.getProduct().getId() == productId) {
                    detail.setQuantity(detail.getQuantity() + quantity);
                    detail.setUnitPrice(unitPrice);
                    existed = true;
                    break;
                }
            }
            if (!existed) {
                PurchaseDetail detail = new PurchaseDetail();
                detail.setProduct(product);
                detail.setQuantity(quantity);
                detail.setUnitPrice(unitPrice);
                cart.add(detail);
            }

            setSuccess(session, "Đã thêm sản phẩm " + product.getName() + " vào phiếu nhập.");
        } catch (NumberFormatException ex) {
            setError(session, "Mã sản phẩm không hợp lệ.");
        }

        redirect(request, response, "/purchase");
    }

    private void handleRemoveProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String productIdParam = request.getParameter("productId");
        if (productIdParam != null) {
            try {
                int productId = Integer.parseInt(productIdParam);
                List<PurchaseDetail> cart = getOrCreateCart(session);
                cart.removeIf(detail -> detail.getProduct().getId() == productId);
                setSuccess(session, "Đã xóa sản phẩm khỏi phiếu nhập.");
            } catch (NumberFormatException ex) {
                setError(session, "Mã sản phẩm không hợp lệ.");
            }
        }
        redirect(request, response, "/purchase");
    }

    private void handleCreateInvoice(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Supplier supplier = (Supplier) session.getAttribute("selectedSupplier");
        Member user = (Member) session.getAttribute("user");
        List<PurchaseDetail> cart = getCart(session);

        if (supplier == null || user == null || cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Vui lòng chọn nhà cung cấp và thêm sản phẩm.");
            forward(request, response, PURCHASE_VIEW);
            return;
        }

        PurchaseInvoice invoice = new PurchaseInvoice();
        invoice.setPaymentDate(new Date(System.currentTimeMillis()));
        invoice.setPaymentType(request.getParameter("paymentType"));
        invoice.setSupplier(supplier);

        if (!employeeDAO.ensureEmployee(user.getId(), "Nhân viên")) {
            request.setAttribute("error", "Không thể xác định nhân viên thực hiện phiếu nhập.");
            forward(request, response, PURCHASE_VIEW);
            return;
        }

        Employee employee = new Employee();
        employee.setId(user.getId());
        invoice.setEmployee(employee);
        invoice.setListPD(cart);

        int invoiceId = purchaseDAO.addPurchaseInvoice(invoice);
        if (invoiceId > 0) {
            session.removeAttribute("cart");
            session.removeAttribute("selectedSupplier");
            setSuccess(session, "Tạo phiếu nhập thành công. Mã phiếu: " + invoiceId);
            redirect(request, response, "/purchase");
        } else {
            request.setAttribute("error", "Tạo phiếu nhập thất bại.");
            forward(request, response, PURCHASE_VIEW);
        }
    }

    private void handleAddSupplier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Supplier supplier = new Supplier();
        supplier.setName(request.getParameter("name"));
        supplier.setAddress(request.getParameter("address"));
        supplier.setPhoneNumber(request.getParameter("phone"));
        supplier.setEmail(request.getParameter("email"));

        boolean success = supplierDAO.addSupplier(supplier);
        if (success) {
            setSuccess(session, "Đã thêm nhà cung cấp mới.");
        } else {
            setError(session, "Không thể thêm nhà cung cấp.");
        }
        redirect(request, response, "/purchase?action=supplierSearch");
    }

    private void handleAddNewProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Product product = new Product();
        product.setName(request.getParameter("name"));
        product.setUnitPrice(parsePositiveFloat(request.getParameter("price"), 0));
        product.setBrand(request.getParameter("brand"));
        product.setCategory(request.getParameter("category"));
        product.setUnit(request.getParameter("unit"));

        if (product.getUnitPrice() <= 0) {
            setError(session, "Đơn giá sản phẩm phải lớn hơn 0.");
            redirect(request, response, "/purchase?action=productSearch");
            return;
        }

        boolean success = productDAO.addProduct(product);
        if (success) {
            setSuccess(session, "Đã thêm sản phẩm mới.");
        } else {
            setError(session, "Không thể thêm sản phẩm.");
        }
        redirect(request, response, "/purchase?action=productSearch");
    }

    private void forwardToSummary(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        forward(request, response, PURCHASE_VIEW);
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String view) throws ServletException, IOException {
        request.getRequestDispatcher(view).forward(request, response);
    }

    private void preloadSuppliers(HttpServletRequest request) {
        List<Supplier> suppliers = supplierDAO.searchSupplier("");
        request.setAttribute("suppliers", suppliers);
    }

    private void preloadProducts(HttpServletRequest request) {
        List<Product> products = productDAO.searchProduct("");
        request.setAttribute("products", products);
    }

    private List<PurchaseDetail> getCart(HttpSession session) {
        Object cart = session.getAttribute("cart");
        if (cart instanceof List<?>) {
            @SuppressWarnings("unchecked")
            List<PurchaseDetail> details = (List<PurchaseDetail>) cart;
            return details;
        }
        return null;
    }

    private List<PurchaseDetail> getOrCreateCart(HttpSession session) {
        List<PurchaseDetail> cart = getCart(session);
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private int parsePositiveInt(String value, int fallback) {
        try {
            int parsed = Integer.parseInt(value);
            return parsed > 0 ? parsed : fallback;
        } catch (NumberFormatException ex) {
            return fallback;
        }
    }

    private float parsePositiveFloat(String value, float fallback) {
        try {
            float parsed = Float.parseFloat(value);
            return parsed > 0 ? parsed : fallback;
        } catch (NumberFormatException ex) {
            return fallback;
        }
    }

    private void setSuccess(HttpSession session, String message) {
        session.setAttribute("purchaseSuccess", message);
        session.removeAttribute("purchaseError");
    }

    private void setError(HttpSession session, String message) {
        session.setAttribute("purchaseError", message);
        session.removeAttribute("purchaseSuccess");
    }

    private void redirect(HttpServletRequest request, HttpServletResponse response, String path) throws IOException {
        response.sendRedirect(request.getContextPath() + path);
    }
}
