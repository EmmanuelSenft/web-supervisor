<tr>
    <td>{% if launcher.reachable %}
        {% if launcher.readytolaunch %}
        <button id="{{launcher.name}}_startstop" alt="Start this launch file" class="btn btn-lg btn-success" onclick="launch.call($(this),'{{launcher.name}}',this.value)" value="start"><i class="fa fa-play"></i></button>
        {% else %}
        <button alt="Some arguments are missing" class="btn btn-lg btn-warning" onclick="$('#{{launcher.name}}_args_btn').trigger('click')"><i class="fa fa-question"></i></button>
        {% endif %}
        {% else %}
        <span class="label label-warning"><i class="fa fa-question"></i></span>
        {% endif %}
    </td>
    <td><h3>{{ "%s" % launcher.prettyname}}</h3></td>
    <td>{% if launcher.has_args %}
        <button id="{{launcher.name}}_args_btn" class="btn btn-md btn-info" data-toggle="button" onclick="$('#{{launcher.name}}_args').toggle('fast');$(':first-child',this).toggleClass('fa-plus fa-minus')"><i {% if showargs %}class="fa fa-minus"{% else %}class="fa fa-plus"{% endif %}></i></button>
        {% endif %}
    </td>
    <td>
        {% if launcher.has_args %}
        <ul id="{{launcher.name}}_args" {% if not showargs %}style="display:none"{% endif %} class="list-group">
            {% for arg, values in launcher.args.items() %}
                <li class="list-group-item">
                    <form class="form-inline">
                    {% if values[2] == 'bool' %}
                    <input class="form-control"
                           type='checkbox'
                           {{'checked' if values[1]}}
                           onchange="setarg.call($(this),'{{launcher.name}}','{{arg}}',this.checked)" />
                    {% endif %}
                    <strong>{{ arg }}</strong>
                    {% if values[2] != 'bool' %}: 
                    <input class="form-control"
                            {% if values[2] in ['int', 'float'] %}
                              type='number' value="{{ values[1] }}"
                            {% elif not values[1] %}
                              style="background-color:#eb9316;"
                            {% else %}
                              value="{{ values[1] }}" 
                            {% endif %}
                           onchange="setarg.call($(this),'{{launcher.name}}','{{arg}}',this.value)" />
                    {% endif %}
                    {% if values[0] %}
                    <br/><em>{{ values[0] }}</em>
                    {% endif %}
                    </form>
                </li>
            {% endfor %}
        </ul>
        {% else %}{{launcher.desc}}</span>
        {% endif %}
    </td>
</tr>

