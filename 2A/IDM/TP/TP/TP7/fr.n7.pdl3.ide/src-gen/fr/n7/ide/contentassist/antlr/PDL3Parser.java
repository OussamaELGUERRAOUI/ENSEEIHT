/*
 * generated by Xtext 2.17.1
 */
package fr.n7.ide.contentassist.antlr;

import com.google.common.collect.ImmutableMap;
import com.google.inject.Inject;
import com.google.inject.Singleton;
import fr.n7.ide.contentassist.antlr.internal.InternalPDL3Parser;
import fr.n7.services.PDL3GrammarAccess;
import java.util.Map;
import org.eclipse.xtext.AbstractElement;
import org.eclipse.xtext.ide.editor.contentassist.antlr.AbstractContentAssistParser;

public class PDL3Parser extends AbstractContentAssistParser {

	@Singleton
	public static final class NameMappings {
		
		private final Map<AbstractElement, String> mappings;
		
		@Inject
		public NameMappings(PDL3GrammarAccess grammarAccess) {
			ImmutableMap.Builder<AbstractElement, String> builder = ImmutableMap.builder();
			init(builder, grammarAccess);
			this.mappings = builder.build();
		}
		
		public String getRuleName(AbstractElement element) {
			return mappings.get(element);
		}
		
		private static void init(ImmutableMap.Builder<AbstractElement, String> builder, PDL3GrammarAccess grammarAccess) {
			builder.put(grammarAccess.getProcessElementAccess().getAlternatives(), "rule__ProcessElement__Alternatives");
			builder.put(grammarAccess.getWorkSequenceTypeAccess().getAlternatives(), "rule__WorkSequenceType__Alternatives");
			builder.put(grammarAccess.getProcessAccess().getGroup(), "rule__Process__Group__0");
			builder.put(grammarAccess.getProcessElementAccess().getGroup_0(), "rule__ProcessElement__Group_0__0");
			builder.put(grammarAccess.getProcessElementAccess().getGroup_1(), "rule__ProcessElement__Group_1__0");
			builder.put(grammarAccess.getWorkDefinitionAccess().getGroup(), "rule__WorkDefinition__Group__0");
			builder.put(grammarAccess.getWorkSequenceAccess().getGroup(), "rule__WorkSequence__Group__0");
			builder.put(grammarAccess.getProcessAccess().getNameAssignment_1(), "rule__Process__NameAssignment_1");
			builder.put(grammarAccess.getProcessAccess().getProcessElementsAssignment_2(), "rule__Process__ProcessElementsAssignment_2");
			builder.put(grammarAccess.getProcessElementAccess().getWorkDefinitionAssignment_0_1(), "rule__ProcessElement__WorkDefinitionAssignment_0_1");
			builder.put(grammarAccess.getProcessElementAccess().getWorkSequenceAssignment_1_1(), "rule__ProcessElement__WorkSequenceAssignment_1_1");
			builder.put(grammarAccess.getWorkDefinitionAccess().getNameAssignment_0(), "rule__WorkDefinition__NameAssignment_0");
			builder.put(grammarAccess.getWorkSequenceAccess().getPredecessorAssignment_0(), "rule__WorkSequence__PredecessorAssignment_0");
			builder.put(grammarAccess.getWorkSequenceAccess().getLinkTypeAssignment_1(), "rule__WorkSequence__LinkTypeAssignment_1");
			builder.put(grammarAccess.getWorkSequenceAccess().getSuccessorAssignment_2(), "rule__WorkSequence__SuccessorAssignment_2");
		}
	}
	
	@Inject
	private NameMappings nameMappings;

	@Inject
	private PDL3GrammarAccess grammarAccess;

	@Override
	protected InternalPDL3Parser createParser() {
		InternalPDL3Parser result = new InternalPDL3Parser(null);
		result.setGrammarAccess(grammarAccess);
		return result;
	}

	@Override
	protected String getRuleName(AbstractElement element) {
		return nameMappings.getRuleName(element);
	}

	@Override
	protected String[] getInitialHiddenTokens() {
		return new String[] { "RULE_WS", "RULE_ML_COMMENT", "RULE_SL_COMMENT" };
	}

	public PDL3GrammarAccess getGrammarAccess() {
		return this.grammarAccess;
	}

	public void setGrammarAccess(PDL3GrammarAccess grammarAccess) {
		this.grammarAccess = grammarAccess;
	}
	
	public NameMappings getNameMappings() {
		return nameMappings;
	}
	
	public void setNameMappings(NameMappings nameMappings) {
		this.nameMappings = nameMappings;
	}
}
