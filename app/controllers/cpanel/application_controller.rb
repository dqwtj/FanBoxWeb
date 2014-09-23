# coding: utf-8
class Cpanel::ApplicationController < ApplicationController
  
  layout "cpanel"
  
  http_basic_authenticate_with name: "fanhe", password: "zqpm01"
  
end