<#-- 
Header section of the GetFeatureInfo HTML output. Should have the <head> section, and
a starter of the <body>. It is advised that eventual css uses a special class for featureInfo,
since the generated HTML may blend with another page changing its aspect when usign generic classes
like td, tr, and so on. 
-->

<html>
  <head>
    <title>Geoserver GetFeatureInfo output</title>
  </head>
  <style type="text/css">
    table.featureInfo {
        font-family: sans-serif;
        width: 100%;
        border: 1px solid #eee;
    }
    table.featureInfo caption {
        background-color: #ddd;
    }
    table.featureInfo, table.featureInfo td, table.featureInfo th {
        border-collapse: collapse;
        margin: 0;
        padding: 0;
        /*font-size: 90%;*/
        padding: .2em .1em;
    }
    table.featureInfo th {
        padding: .2em .2em;
        font-weight: bold;
        background: #eee;
    }
    table.featureInfo td {
        background: #fff;
        vertical-align: top;
    }

    table.featureInfo img {
        max-width: 100%;
    }

    table.featureInfo tr.odd td{
        background: #eee;
    }
    table.featureInfo caption{
        text-align: left;
        font-size: 100%;
        font-weight: bold;
        padding: .2em .2em;
    }

    table.jsonFeatureInfo, table.jsonFeatureInfo td, table.jsonFeatureInfo th {
        border-collapse: collapse;
        margin: 0;
        padding: 0;
        /*font-size: 90%;*/
        padding: 0.1em 0.1em;
    }

  </style>
  <body>
  
