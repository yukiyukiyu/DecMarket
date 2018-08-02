package com.yuki.decmarket.filter;

import com.yuki.decmarket.util.CoverHelper;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CoverFilter implements Filter {

    private CoverHelper coverHelper = null;

    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String uri = request.getRequestURI();
        if (uri.equals("/resources/img/cover/default"))
            chain.doFilter(request, response);
        else {
            String[] uriList = uri.split("/");
            int goodId = Integer.parseInt(uriList[uriList.length - 1]);
            if (coverHelper.checkCoverByGoodId(goodId))
                chain.doFilter(request, response);
            else
                response.sendRedirect(coverHelper.getCoverByGoodId(goodId));
        }
    }

    public void init(FilterConfig config) throws ServletException {
        this.coverHelper = new CoverHelper();
    }
}
