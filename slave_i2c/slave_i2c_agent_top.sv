class slave_i2c_agent_top extends uvm_env;

`uvm_component_utils(slave_i2c_agent_top)

slave_i2c_agent agnth[];

i2c_env_config e_cfg;

extern function new(string name="slave_i2c_agent_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

//new constructor
function slave_i2c_agent_top::new(string name="slave_i2c_agent_top",uvm_component parent);
	super.new(name,parent);
endfunction

//build_phase
function void slave_i2c_agent_top::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(i2c_env_config)::get(this,"","i2c_env_config",e_cfg))
	`uvm_fatal("AGT TOP","cannot get the e_cfg from i2c_env_config DB")
	
	if(e_cfg.has_agent_top)
	agnth=new[e_cfg.no_of_agents];
	foreach(agnth[i])
	begin
		uvm_config_db #(slave_i2c_agent_config)::set(this,$sformatf("agnth[%0d]*",i),"slave_i2c_agent_config",e_cfg.slave_agt_cfg[i]);
		agnth[i]=slave_i2c_agent::type_id::create($sformatf("agnth[%0d]",i),this);
	end

endfunction

task slave_i2c_agent_top::run_phase(uvm_phase phase);
	uvm_top.print_topology();
endtask
