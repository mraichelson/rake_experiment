/**
 * @depends jquery-1.6.2.min.js
 */
/*!
 * File preamble, License, etc.
 * @author X McY <xy@z.a>
 */
/*jslint nomen:true, sloppy:true, maxerr:50, indent:2 */
/*global $:true, jQuery:true */

var Project = this.Project || {};

Project.config = {
  animspeed : c500
};

Project.func = {
  cloneElement : function (domElement) {
    var $local;
    $local = $(domElement);
    $('body').append($local.clone(true));
  }
};

Project.init = function () {
  $('h1').each(function () {
    Project.func.cloneElement(this);
  });
  if ($.browser.msie) {
    Project.initIE();
  }
};

Project.initIE = function () {
  $('html').addClass('internet-explorer');
};

$(function () {
  Project.init();
});