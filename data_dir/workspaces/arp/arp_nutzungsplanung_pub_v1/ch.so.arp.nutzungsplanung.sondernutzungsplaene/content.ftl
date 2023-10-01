<#-- 
Body section of the GetFeatureInfo template, it's provided with one feature collection, and
will be called multiple times if there are various feature collections
-->

<#macro formatDate dateAttr>
  ${dateAttr.rawValue?date?string["dd.MM.yyyy"]}
</#macro>

<#macro formatJsonDate dateAttr>
  ${dateAttr?date.iso?string("dd.MM.yyyy")}
</#macro>

<#list features as feature>
  <#assign attrs = feature.attributes>
  <table class="featureInfo">

    <#if feature.attributes['t_id']??>
      <caption class="featureInfo">${feature.type.title}: ${feature.attributes['t_id'].value}</caption>
    <#else>
      <caption class="featureInfo">${feature.type.title} </caption>
    </#if>

    <colgroup>
      <col style="width:40%">
      <col style="width:60%">
    </colgroup>

    <tbody>
      <tr>
        <td>Typ-Bezeichnung:</td>
        <td>${feature.attributes['typ_bezeichnung'].value}</td>
      </tr>

      <tr class="odd">
        <td>In Kraft:</td>
        <td><@formatDate dateAttr=feature.attributes['publiziertab']/></td>
      </tr>

      <#if "${feature.attributes['dokumente'].value}" != "">
        <#assign parsed = feature.attributes['dokumente'].value?eval_json>
        <#-- Ohne ili2pg-Spezialfall. Wird eh gefixed. -->

        <#assign odd = false>
        <#list parsed?sort_by('Titel') as jsonObj>
          <#if odd>
            <tr class="odd">
          <#else>
            <tr>
          </#if>
          <#assign odd = !odd>
            <td>${jsonObj['Titel']}</td>
            <#if jsonObj['Titel'] != 'Regierungsratsbeschluss'>
              <td><a href="${jsonObj['TextimWeb']}" target="_blank">${jsonObj['OffiziellerTitel']}</a></td>
            <#else>
              <td><a href="${jsonObj['TextimWeb']}" target="_blank">${jsonObj['Abkuerzung']} ${jsonObj['OffizielleNr']}</a> vom <@formatJsonDate dateAttr=jsonObj['publiziertAb']/> <br> ${jsonObj['OffiziellerTitel']}</td>
            </#if> 
          <tr>
        </#list>
      </#if>
    </tbody>
  </table>
  <br>
</#list>
<br/>

