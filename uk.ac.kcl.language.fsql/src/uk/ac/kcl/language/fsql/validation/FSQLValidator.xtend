/*
 * generated by Xtext 2.25.0
 */
package uk.ac.kcl.language.fsql.validation

import uk.ac.kcl.language.fsql.fSQL.AddRow
import uk.ac.kcl.language.fsql.fSQL.FSQLPackage
import uk.ac.kcl.language.fsql.fSQL.FSQL
import org.eclipse.emf.common.util.EList
import uk.ac.kcl.language.fsql.fSQL.TableStatements
import uk.ac.kcl.language.fsql.fSQL.SchemaDeclaration
import java.util.List
import uk.ac.kcl.language.fsql.fSQL.ColumnDeclaration
import uk.ac.kcl.language.fsql.fSQL.SimpleDeclaration
import org.eclipse.xtext.validation.Check
import uk.ac.kcl.language.fsql.fSQL.CreateTable
import uk.ac.kcl.language.fsql.fSQL.TableStatement
import uk.ac.kcl.language.fsql.fSQL.PrimaryKey
import uk.ac.kcl.language.fsql.fSQL.AddRows
import uk.ac.kcl.language.fsql.typing.validation.FSQLTypeSystemValidator
import uk.ac.kcl.language.fsql.fSQL.TableDeclaration
import uk.ac.kcl.language.fsql.fSQL.DropTable
import uk.ac.kcl.language.fsql.fSQL.Delete
import uk.ac.kcl.language.fsql.fSQL.Update
import uk.ac.kcl.language.fsql.fSQL.Query
import uk.ac.kcl.language.fsql.fSQL.Join
import uk.ac.kcl.language.fsql.fSQL.InitTable
import uk.ac.kcl.language.fsql.fSQL.SelectStatement
import uk.ac.kcl.language.fsql.fSQL.AddColumn
import uk.ac.kcl.language.fsql.fSQL.AlterTable
import uk.ac.kcl.language.fsql.fSQL.AddColumns
import uk.ac.kcl.language.fsql.fSQL.DropColumn
import uk.ac.kcl.language.fsql.fSQL.DropColumns
import uk.ac.kcl.language.fsql.fSQL.ModifyColumns

/**
 * This class contains custom validation rules. 
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
class FSQLValidator extends FSQLTypeSystemValidator {
	
	public static val INVALID_NAME = 'invalidName';
	public static val MISSING_DB = 'db not in use';
	public static val INVALID_ADD_ROW = 'columns missing';
	public static val INVALID_TABLE_DECLARATION = 'cannot reference table';


	@Check
	def checkProgramStartsWithDB(FSQL program) {
			if (program.dbStatements.length < 1) {
				error('Missing database use', 
						FSQLPackage.Literals.FSQL__DB_STATEMENTS,
						MISSING_DB)
			}
	}

	@Check(NORMAL)
	def checkAddRowsContainsAllColumns(FSQL program) {
			if (!program.tableStatements.checkAddRowsContainsAllColumns(true)) {
				warning('Check again AddRow statements to contain all columns!', 
						FSQLPackage.Literals.FSQL__TABLE_STATEMENTS,
						INVALID_ADD_ROW)
			}
	}

	@Check(NORMAL)
	def checkTableReferenceAfterDropDelete(Delete stmt) {
		println("DELTE STMT: " + stmt.toString());
		val model = stmt.eContainer() as FSQL;
		if (!model.tableStatements.checkTableReferencedAfterDrop(stmt.toString())) {
				warning('Cannot reference table after drop!', 
						FSQLPackage.Literals.DELETE__TABLE,
						INVALID_TABLE_DECLARATION)
		}
	}

	
	@Check(NORMAL)
	def checkTableReferenceAfterDropUpdate(Update stmt) {
		val model = stmt.eContainer() as FSQL;
		if (!model.tableStatements.checkTableReferencedAfterDrop(stmt.toString())) {
				warning('Cannot reference table after drop!', 
						FSQLPackage.Literals.UPDATE__TABLE,
						INVALID_TABLE_DECLARATION)
		}
	}
	
	@Check(NORMAL)
	def checkTableReferenceAfterDropAddRow(AddRow stmt) {
		val model = stmt.eContainer() as FSQL;
		if (!model.tableStatements.checkTableReferencedAfterDrop(stmt.toString())) {
				warning('Cannot reference table after drop!', 
						FSQLPackage.Literals.ADD_ROW__TABLE,
						INVALID_TABLE_DECLARATION)
		}
	}
	
	@Check(NORMAL)
	def checkTableReferenceAfterDropAddRows(AddRows stmt) {
		val model = stmt.eContainer() as FSQL;
		if (!model.tableStatements.checkTableReferencedAfterDrop(stmt.toString())) {
				warning('Cannot reference table after drop!', 
						FSQLPackage.Literals.ADD_ROWS__TABLE,
						INVALID_TABLE_DECLARATION)
		}
	}
	
	@Check(NORMAL)
	def checkTableReferenceAfterDropDropTable(DropTable stmt) {
		val model = stmt.eContainer() as FSQL;
		if (!model.tableStatements.checkTableReferencedAfterDrop(stmt.toString())) {
				warning('Cannot reference table after drop!', 
						FSQLPackage.Literals.DROP_TABLE__TABLE,
						INVALID_TABLE_DECLARATION)
		}
	}
	
	@Check(NORMAL)
	def checkTableReferenceAfterDropDropTable(Query stmt) {
		val model = stmt.eContainer() as FSQL;
		if (!model.tableStatements.checkTableReferencedAfterDrop(stmt.toString())) {
				warning('Cannot reference table after drop!', 
						FSQLPackage.Literals.QUERY__TABLE,
						INVALID_TABLE_DECLARATION)
		}
	}
	
	@Check(NORMAL)
	def checkTableReferenceAfterDropDropTable(AlterTable stmt) {
		val model = stmt.eContainer() as FSQL;
		if (!model.tableStatements.checkTableReferencedAfterDrop(stmt.toString())) {
				warning('Cannot reference table after drop!', 
						FSQLPackage.Literals.ALTER_TABLE__TABLE,
						INVALID_TABLE_DECLARATION)
		}
	}
	
	@Check(NORMAL)
	def checkTableReferenceAfterDropDropTable(SelectStatement stmt) {
		val model = stmt.eContainer() as FSQL;
		if (!model.tableStatements.checkTableReferencedAfterDrop(stmt.toString())) {
				warning('Cannot reference table after drop!', 
						FSQLPackage.Literals.SELECT_STATEMENT__TABLE,
						INVALID_TABLE_DECLARATION)
		}
	}
	
	def boolean checkTableReferencedAfterDrop(EList<TableStatements> statements, String stmt) {
		var Integer stmtIndex = 0;
		var String stmtTable = '';
		
		for (i : 0 .. statements.length - 1) {
			if (statements.get(i).toString() == stmt) {
				stmtIndex = i;
				stmtTable = statements.get(i).getTableName();
			}
		}
		
		for (i : 0 .. statements.length - 1) {
			if (statements.get(i).class.typeName.toString().contains('DropTableImpl')) {
				if (statements.get(i).getTableName() == stmtTable && i < stmtIndex) {
					return false;
				} 
			}
		}
		return true;
	}
	
	dispatch def String getTableName(CreateTable table) {
		return '';
	}
	
	dispatch def String getTableName(SelectStatement select) {
		return select.table.^var.name;
	}
	
	dispatch def String getTableName(InitTable table) {
		return '';
	}
	
	dispatch def String getTableName(SchemaDeclaration table) {
		return table.table.get(0).^var.name;
	}
	
	dispatch def String getTableName(TableStatement table) {
		return '';
	}
	
	dispatch def String getTableName(AddRow row) {
		return row.table.get(0).^var.name;
	}
	
	dispatch def String getTableName(AddRows rows) {
		return rows.table.get(0).^var.name;
	}
	
	dispatch def String getTableName(Delete delete) {
		return delete.table.get(0).^var.name.toString();
	}
	
	dispatch def String getTableName(Update update) {
		return update.table.get(0).^var.name;
	}
	
	dispatch def String getTableName(Query query) {
		return query.table.^var.name.toString();
	}
	
	dispatch def String getTableName(Join join) {
		return join.table1.^var.name + join.table2.^var.name;
	}
	
	dispatch def String getTableName(DropTable dropTable) {
		return dropTable.table.^var.name;
	}
	
	dispatch def String getTableName(TableDeclaration tableDecl) {
		return tableDecl.^var.name
	}
	
	dispatch def String getTableName(AlterTable col) {
		return '';
	}
	
	dispatch def String getTableName(AddColumn col) {
		return col.table.get(0).^var.name;
	}
	
	dispatch def String getTableName(AddColumns col) {
		return col.table.get(0).^var.name;
	}
	
	dispatch def String getTableName(DropColumn col) {
		return col.table.get(0).^var.name;
	}
	
	dispatch def String getTableName(DropColumns col) {
		return col.table.get(0).^var.name;
	}
	
	dispatch def String getTableName(ModifyColumns col) {
		return col.table.get(0).^var.name;
	}
	
	
	def  boolean checkAddRowsContainsAllColumns(EList<TableStatements> statements, boolean state) {
		var List<List<String>> schemas = newArrayList;
		var List<List<String>> rows = newArrayList;
		
		for (i : 0 .. statements.length - 1) {
			var className = statements.get(i).class.typeName.toString().split('impl.').get(1);
			var List<List<String>> col = statements.get(i).getColumns(state);
			
			if (className == 'SchemaDeclarationImpl') {
				schemas.add(col.get(0));
			} else if (className == 'AddRowImpl') {
				rows.add(col.get(0))
			} else if (className == 'AddRowsImpl') {
				for (j: 0..col.length - 1) {
					rows.add(col.get(j));
				}
			}
		}
		
		if (rows.length != 0) {
			var List<String> res = newArrayList;
			for (j: 0 .. rows.length - 1) {
				var result = checkColumns(schemas, rows.get(j));
				res.add(result.toString());
			}
			
			if (res.contains('false')) {
				return false;
			} else {
				return true;
			}
		} else {
			return true;
		}
	}
	
	def boolean checkColumns(List<List<String>> schemas, List<String> row) {
		for (j: 0 .. schemas.length - 1) {
			if (schemas.get(j).get(0) == row.get(0)) {
				return compareLists(schemas.get(j), row);
			}
		}
	}
	
	def boolean compareLists(List<String> original, List<String> copy) {
		for (i: 1..original.length - 1) {
			if (!copy.contains(original.get(i)) ) {
				return false;
			}
		}
		
		return true;
	}
	
	dispatch def getColumns(TableStatements statement, boolean state) {
		var List<List<String>> columns = newArrayList;
		return columns;
	}
	
	dispatch def getColumns(CreateTable statement, boolean state) {
		var List<List<String>> columns = newArrayList;
		return columns;
	}
	
	dispatch def getColumns(TableStatement statement, boolean state) {
		var List<List<String>> columns = newArrayList;
		return columns;
	}
	
	dispatch def getColumns(SchemaDeclaration schema, boolean state) {
		var List<String> columns = newArrayList;
		columns.add(schema.table.get(0).^var.name.toString());
		
		var column = schema.column.get(0).getColumnName;
		
		if (column != '') {
				columns.add(column);
		}
		
		for (i: 0 .. schema.columns.length - 1) {
			column = schema.columns.get(i).getColumnName;
			
			if (column != '') {
				columns.add(column);
			}
		}
		
		var List<List<String>> result = newArrayList;
		result.add(columns);
		return result;
	}
	
	dispatch def String getColumnName(ColumnDeclaration column) {
		return '';
	}
	
	dispatch def String getColumnName(SimpleDeclaration column) {
		return column.getName().toString();
	}
	
	dispatch def String getColumnName(PrimaryKey column) {
		return column.column.getColumnName;
	}
	
	dispatch def getColumns(AddRow row, boolean state) {
		var List<String> columns = newArrayList;

		columns.add(row.table.get(0).^var.name.toString());
		for (i: 0 .. row.row.length - 1) {
			columns.add(row.row.get(i).column.column.^var.columnName);
			
			if (row.row.get(i).columns.length != 0) {
				for (j: 0 .. row.row.get(i).columns.length - 1) {
					columns.add(row.row.get(i).columns.get(j).column.^var.columnName);
					println(row.row.get(i).columns.get(j).column.^var.columnName);
				}	
			}
			
		}
		var List<List<String>> result = newArrayList;
		result.add(columns);
		return result;
	}
	
	dispatch def getColumns(AddRows rows, boolean state) {
		var List<List<String>> allColumns = newArrayList;
		
		var List<String> columns = newArrayList;

		columns.add(rows.table.get(0).^var.name.toString());
		
		columns.add(rows.row.column.column.^var.columnName);
		
		if (rows.row.columns.length != 0) {
			for (i: 0 .. rows.row.columns.length - 1) {
				columns.add(rows.row.columns.get(i).column.^var.columnName);
			}
		}
		
		allColumns.add(columns);
		
		for (i: 0 .. rows.rows.length - 1) {
			var List<String> cols = newArrayList;
			
			cols.add(rows.table.get(0).^var.name.toString());
			cols.add(rows.rows.get(i).column.column.^var.columnName);
			
			if (rows.rows.get(i).columns.length != 0) {
				for (j: 0 .. rows.rows.get(i).columns.length - 1) {
					cols.add(rows.rows.get(i).columns.get(j).column.^var.columnName);
				}	
			}
			allColumns.add(cols);
		}
		return allColumns;
	}
}