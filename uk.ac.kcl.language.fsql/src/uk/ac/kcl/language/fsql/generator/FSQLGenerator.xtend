/*
 * generated by Xtext 2.25.0
 */
package uk.ac.kcl.language.fsql.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import uk.ac.kcl.language.fsql.fSQL.FSQL
import uk.ac.kcl.language.fsql.fSQL.DatabaseStatements
import uk.ac.kcl.language.fsql.fSQL.CreateDB
import uk.ac.kcl.language.fsql.fSQL.UseDB
import uk.ac.kcl.language.fsql.fSQL.TableStatements
import uk.ac.kcl.language.fsql.fSQL.CreateTable
import uk.ac.kcl.language.fsql.fSQL.InitTable
import uk.ac.kcl.language.fsql.fSQL.SchemaDeclaration
import uk.ac.kcl.language.fsql.fSQL.ColumnDeclaration
import uk.ac.kcl.language.fsql.fSQL.SimpleDeclaration
import uk.ac.kcl.language.fsql.fSQL.PrimaryKey
import uk.ac.kcl.language.fsql.fSQL.ColumnType
import uk.ac.kcl.language.fsql.fSQL.ForeignKey
import uk.ac.kcl.language.fsql.fSQL.CompositeKey
import uk.ac.kcl.language.fsql.fSQL.ColumnNameReference
import uk.ac.kcl.language.fsql.fSQL.TableStatement
import uk.ac.kcl.language.fsql.fSQL.DropTable
import uk.ac.kcl.language.fsql.fSQL.AddRow
import uk.ac.kcl.language.fsql.fSQL.RowDeclaration
import uk.ac.kcl.language.fsql.fSQL.AssignColumnValue
import uk.ac.kcl.language.fsql.fSQL.AddRows
import uk.ac.kcl.language.fsql.fSQL.Delete
import uk.ac.kcl.language.fsql.fSQL.WhereClause
import uk.ac.kcl.language.fsql.fSQL.Condition
import uk.ac.kcl.language.fsql.fSQL.ConditionOperator
import uk.ac.kcl.language.fsql.fSQL.Operator
import uk.ac.kcl.language.fsql.fSQL.ConditionalOperator
import uk.ac.kcl.language.fsql.fSQL.Update

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class FSQLGenerator extends AbstractGenerator {

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		val model = resource.contents.head as FSQL
		
		val className = resource.deriveClassNameFor
		
		fsa.generateFile(className + '.sql', model.doGenerateCode)
	}
	
	def deriveClassNameFor(Resource resource) {
		val origName = resource.URI.lastSegment

		origName.substring(0, origName.indexOf('.'))
	}
	
	def String doGenerateCode(FSQL program) '''
		«program.dbStatements.map[generateSQLDBCommand].join('\n')»
		«program.tableStatements.map[generateSQLTableCommand].join('\n')»
	'''
	
	dispatch def String generateSQLDBCommand(DatabaseStatements dbStmt) '''
	'''
	
	dispatch def String generateSQLDBCommand(CreateDB createDB) '''
		CREATE DATABASE «createDB.getName»;
	'''
	
	dispatch def String generateSQLDBCommand(UseDB useDB) '''
		USE «useDB.getDatabase().^var.name»;
	'''
	
	dispatch def String generateSQLTableCommand(TableStatements tableStmt)'''
	'''
	
	dispatch def String generateSQLTableCommand(CreateTable createTable)'''
	'''
	
	dispatch def String generateSQLTableCommand(InitTable initTable)'''
	'''
	
	dispatch def String generateSQLTableCommand(TableStatement tableStmt)'''
	'''
	
	dispatch def String generateSQLTableCommand(DropTable command)'''
		DROP TABLE «command.table.^var.name»;
	'''
	
	dispatch def String generateSQLTableCommand(SchemaDeclaration schema)'''
		CREATE TABLE «schema.table.get(0).^var.name»(
			«schema.column.map[generateSQLColumns].join('')»
			«schema.columns.map[generateSQLColumns].join('\n')»
		)'''
	
	// this will generate SQL code for each column declaration
	dispatch def String generateSQLColumns(ColumnDeclaration column)''''''
	
	dispatch def String generateSQLColumns(SimpleDeclaration column)'''«column.getName» «if (column.type === ColumnType.BOOL) {'''NUMBER(1)'''} else if (column.type === ColumnType.STRING) {'''VARCHAR(255)'''} else {column.type}»'''
	
	dispatch def String generateSQLColumns(PrimaryKey column)'''«column.column.generateSQLColumns» PRIMARY KEY'''
	
	dispatch def String generateSQLColumns(ForeignKey column)'''FOREIGN KEY «column.getColumn().generateSQLColumnNameReference.substring(2)» REFERENCES «column.table.get(0).^var.name»(«column.getColumn().generateSQLColumnNameReference.substring(2)»)'''
	
	dispatch def String generateSQLColumns(CompositeKey column)'''PRIMARY KEY («column.getColumn().generateSQLColumnNameReference.substring(2)»«column.getColumns().map[generateSQLColumnNameReference].join('')»)'''
	
	def String generateSQLColumnNameReference(ColumnNameReference columnRef) ''', «columnRef.^var.generateSQLColumns.split(' ').get(0)»'''
	
	dispatch def String generateSQLTableCommand(AddRow command)'''INSERT INTO «command.table.get(0).^var.name» («command.row.map[generateRowDeclaration].join('')»);'''
	
	dispatch def String generateSQLTableCommand(AddRows command)'''INSERT INTO «command.table.get(0).^var.name» («command.row.generateRowDeclaration»)«command.rows.map[generateMultipleRows].join('')»;'''
	
	def String generateAssignColumnName(AssignColumnValue assignColumn)'''
	«assignColumn.column.generateSQLColumnNameReference.substring(2)»'''
	
	def String generateAssignColumnValue(AssignColumnValue assignColumn)'''
	«assignColumn.value.toString().split('val: ').get(1).substring(0, assignColumn.value.toString().split('val: ').get(1).length - 1)»'''
	// «assignColumn.value.toString().split(' ').get(2).substring(0, assignColumn.value.toString().split(' ').get(2).length - 1)»'''
	
	def String generateAssignColumn(AssignColumnValue assignColumn)'''
	«assignColumn.generateAssignColumnName»=«assignColumn.generateAssignColumnValue»'''
	
	
	def String generateRowDeclaration(RowDeclaration row)'''«row.column.generateAssignColumnName»«',' + row.columns.map[generateAssignColumnName].join(',')») VALUES («row.column.generateAssignColumnValue»«',' + row.columns.map[generateAssignColumnValue].join(',')»'''
	
	def String generateMultipleRows(RowDeclaration row) ''', («row.column.generateAssignColumnValue»«',' + row.columns.map[generateAssignColumnValue].join(',')»)'''
	
	dispatch def String generateSQLTableCommand(Delete deleteCommand)'''
	«if (deleteCommand.whereClause === null) 
		{'DELETE * FROM '+ deleteCommand.table.get(0).^var.name} 
	else
		{ 'DELETE FROM ' + deleteCommand.table.get(0).^var.name + ' ' + deleteCommand.whereClause.generateWhereClause}
	»'''
	
	def String generateWhereClause(WhereClause whereClause)'''
	 WHERE «whereClause.query.get(0).generateQuery»
	 «if (whereClause.cond !== null) {
	 	whereClause.cond.map[generateOperatorWithCondition].join('')
	 }»
	 '''
	 
	def String generateOperatorWithCondition(ConditionalOperator cond)'''«cond.operator.generateOperatorValue»«cond.queries.generateQuery»'''
	 
	def String generateOperatorValue(Operator op) '''«
		if (op == Operator.AND) {
			' AND '
		} else {
			' OR '
		}»'''
	
	def String generateQuery(Condition condition)'''
	«condition.getColumn().generateSQLColumnNameReference.substring(2)»«condition.getCondition().generateConditionValue»«condition.getValue().toString().split(' ').get(2).substring(0, condition.getValue().toString().split(' ').get(2).length - 1)»
	'''
	
	def String generateConditionValue(ConditionOperator cond)'''
	«if (cond == ConditionOperator.LT) 
		{'<'} 
	 else if (cond == ConditionOperator.GT)
	 	{'>'}
	 else if (cond == ConditionOperator.EQ)
	 	{'='}
	 else if (cond == ConditionOperator.LTE)
	 	{'<='}
	 else if (cond == ConditionOperator.GTE)
	 	{'>='}
	 else
	 	{'!='}
	 »'''
	 
	 dispatch def String generateSQLTableCommand(Update updateCommand)'''
	 UPDATE «updateCommand.table.get(0).^var.name»
	 SET «updateCommand.column.generateAssignColumn»
	 «if (updateCommand.columns !== null) {
	 	',' + updateCommand.columns.map[generateAssignColumn].join(',')
	 }»
	 «if (updateCommand.whereClause !== null) {
	 	updateCommand.whereClause.generateWhereClause
	 }»
	 '''
}