<#-- 
Body section of the GetFeatureInfo template, it's provided with one feature collection, and
will be called multiple times if there are various feature collections
-->

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
            <#-- Muss doch noch mehr Bedingungen geben, oder? Es müssen die Platzhalter vorhanden sein? 
            Ah, nein. Es wird zwar gerechnet, aber einfach nichts replaced. Darum funktionierts. -->
            <#-- Die Berechnung ist aufwändiger. Hier ist nur der ol3-Spezialfall mit diesen 100 und 50 Pixel. Also immer
            die Mitte.-->

            <#elseif attribute.value?starts_with("http")>
              <#assign xx = request.BBOX?remove_beginning("SRSEnvelope[")?remove_ending("]")?split(",")[0]>
              <#assign yy = request.BBOX?remove_beginning("SRSEnvelope[")?remove_ending("]")?split(",")[1]>

              <#assign x1 =  xx?split(":")[0]?string?trim?number> 
              <#assign x2 =  xx?split(":")[1]?string?trim?number> 
              <#assign x =  x1 + (x2 - x1)/2> 

              <#assign y1 =  yy?split(":")[0]?string?trim?number> 
              <#assign y2 =  yy?split(":")[1]?string?trim?number> 
              <#assign y =  y1 + (y2 - y1)/2> 

              <#assign reportUrl = attribute.value?replace("$$feature", feature.t_id.value)?replace("$$x", x?c)?replace("$$y", y?c)>
              <td><a href="${reportUrl}" target="_blank"> ${reportUrl}</a></td>

            <#-- Nicht unendlich robust/stabil. -->
            <#elseif ((attribute.value?string?lower_case?starts_with("[{\"")) && (attribute.value?string?lower_case?ends_with("}]"))) || ((attribute.value?string?lower_case?starts_with("{\"")) && (attribute.value?string?lower_case?ends_with("}"))) >
              <#assign parsed = attribute.value?eval_json>
              <td>
                <table class=jsonFeatureInfo>
                  <colgroup>
                    <col style="width:40%">
                    <col style="width:60%">
                  </colgroup>
                  <tbody>
                    <#-- Den ili2pg-Spezialfall, dass BAG/LIST zu einem einfachen JSON-Objekte gemappt wird, wird korrigiert. Es entsteht neu immer ein Array. -->
                    <#if parsed?is_hash> <#-- ein einzelnes JSON-Objekt (STRUCTURE) -->
                      <#list parsed?keys as key>
                          <tr>
                            <td>${key?string}</td>
                            <td>${parsed[key]?string}</td>
                          </tr>
                      </#list>
                    <#else> <#-- ein Array von JSON-Objekten (BAG/LIST OF STRUCTURE) -->
                      <#list parsed as jsonObj>
                        <#list jsonObj?keys as key>
                          <tr>
                            <td>${key?string}</td>
                            <td>${jsonObj[key]?string}</td>
                          </tr>
                        </#list>
                      </#list>
                    </#if>
                  <tbody>
                </table>
              </td>
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

<br/>

