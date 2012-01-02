package com.flexutil.shell.entity;

/**
 * Java VO with XDOclet2 annotation for AS3 codegen.
 * 
 * @actionscript.class
 * 		bindable = true
 */

public class BaseVO implements java.io.Serializable {
	static final long serialVersionUID=10000001;
    public BaseVO() {
    }
    
    private String code;
    private String description;
    private String status;
    private int    sortOrder;
    
    
    private boolean modified= false;
    private boolean created = false;
    private boolean updated = false;
    private boolean deleted = false;
    
    
	public int getSortOrder() {
		return sortOrder;
	}
	public void setSortOrder(int sortOrder) {
		this.sortOrder = sortOrder;
	}
	public boolean isModified() {
		return modified;
	}
	public void setModified(boolean modified) {
		this.modified = modified;
	}
	public boolean isCreated() {
		return created;
	}
	public void setCreated(boolean created) {
		this.created = created;
	}
	public boolean isUpdated() {
		return updated;
	}
	public void setUpdated(boolean updated) {
		this.updated = updated;
	}
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
    
    
}