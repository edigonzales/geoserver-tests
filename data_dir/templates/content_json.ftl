<#list features as feature>
{
"content" : "this is the content",
"title" : "${feature.type.title}",
"type": "Feature",
"id" : "${feature.fid}",
<#list feature.attributes as attribute>
<#if attribute.isGeometry>
"geometry": ${geoJSON.geomToGeoJSON(attribute.rawValue)},
</#if>
</#list>
"properties": {
<#list feature.attributes as attribute2>
<#if !attribute2.isGeometry>
    <#if attribute2.rawValue?is_date_like>
        "${attribute2.name}": "${attribute2.rawValue?date?string.iso}"
    <#elseif attribute2.value?starts_with("http")>
        <#assign xx = request.BBOX?remove_beginning("SRSEnvelope[")?remove_ending("]")?split(",")[0]>
        <#assign yy = request.BBOX?remove_beginning("SRSEnvelope[")?remove_ending("]")?split(",")[1]>

        <#assign x1 =  xx?split(":")[0]?string?trim?number> 
        <#assign x2 =  xx?split(":")[1]?string?trim?number> 
        <#assign x =  x1 + (x2 - x1)/2> 

        <#assign y1 =  yy?split(":")[0]?string?trim?number> 
        <#assign y2 =  yy?split(":")[1]?string?trim?number> 
        <#assign y =  y1 + (y2 - y1)/2> 

        <#assign reportUrl = attribute2.value?replace("$$feature", feature.t_id.value)?replace("$$x", x?c)?replace("$$y", y?c)>

        "${attribute2.name}": "${reportUrl}"
    <#else>
        "${attribute2.name}": "${attribute2.value}"
    </#if>
</#if>
<#if attribute2_has_next && !attribute2.isGeometry>
,
</#if>
</#list>
}
}
<#if feature_has_next>
,
</#if>
</#list>