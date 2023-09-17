<#-- 
Body section of the GetFeatureInfo template, it's provided with one feature collection, and
will be called multiple times if there are various feature collections
-->

<#list features as feature>
  <#assign attrs = feature.attributes>
  <table class="featureInfo">
    <caption class="featureInfo">${feature.type.title}: ${feature.t_id.value}</caption>
    <colgroup>
      <col style="width:40%">
      <col style="width:60%">
    </colgroup>
    <tbody>
      <#assign odd = false>
      <#list feature.attributes as attribute>
        <#if !attribute.isGeometry>
          <#if odd>
            <tr class="odd">
          <#else>
            <tr>
          </#if>
          <#assign odd = !odd>
            <td>${attribute.name?string}</td>

            <#if attribute.rawValue?is_date_like>
              <td>${attribute.rawValue?date?string["dd.MM.yyyy"]}</td>
            <#elseif (attribute.value?string?lower_case?ends_with("jpg")) || (attribute.value?string?lower_case?ends_with("png"))>
              <td><a href="${attribute.value}" target="_blank"> <img src="${attribute.value}"/></a></td>
            <#else>
              <td>${attribute.value}</td> 
            </#if>
          </tr>
        </#if>
      </#list>
    </tbody>
  </table>
  <br>
</#list>

<!--
<table class="featureInfo">
  <caption class="featureInfo">${type.name}</caption>
  <tr>
  <th>fid</th>
<#list type.attributes as attribute>
  <#if !attribute.isGeometry>
    <th >${attribute.name}</th>
  </#if>
</#list>
  </tr>

<#assign odd = false>
<#list features as feature>
  <#if odd>
    <tr class="odd">
  <#else>
    <tr>
  </#if>
  <#assign odd = !odd>

  <td>${feature.fid} -- ${feature.type.title} -- gaga </td>    
  <#list feature.attributes as attribute>
    <#if !attribute.isGeometry>
      <td>${attribute.value?string}</td>
    </#if>
  </#list>
  </tr>
</#list>
</table>
-->
<br/>

