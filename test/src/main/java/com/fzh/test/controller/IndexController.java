package com.fzh.test.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class IndexController {

    @Value("${server.port}")
    private int port;

    @RequestMapping("/{value}")
    public String getPort(@PathVariable("value") String value) {
        return "hello" + "port=" + port + "value=" + value;
    }
}
