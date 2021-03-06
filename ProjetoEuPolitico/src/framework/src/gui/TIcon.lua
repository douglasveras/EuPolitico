BibliotecaAuxiliarScript.execute('framework.src.gui.TMenuItem');
BibliotecaAuxiliarScript.execute('framework.src.gui.TLabel');
BibliotecaAuxiliarScript.execute('framework.src.gui.TImage');

TIcon = TMenuItem.new();

--~Atributos 
TIcon.id = "TIcon";
TIcon.tImage =  nil;
TIcon.tLabel =  nil;
TIcon.TITULO_UP = "TITULO_UP";
TIcon.TITULO_LEFT = "TITULO_LEFT";
TIcon.TITULO_RIGHT = "TITULO_RIGHT";
TIcon.TITULO_DOWN = "TITULO_DOWN";
TIcon.orientacao =  TIcon.TITULO_UP;

TIcon.isAttTImageAlterado =  false;
TIcon.isAttTLabelAlterado =  false;
TIcon.isAttOrientacaoAlterado =  false;

function TIcon.__index(tabela,chave)
	return TIcon[chave];
end


function TIcon.new(obj)
	local retorno = obj or {};
	retorno = setmetatable(retorno,TIcon);
	return retorno;
end

--~Func�es 
function TIcon:draw()
	local img_icone = nil;
	local lb_icone = nil;
	local img_icone_updated = false;
	local lb_icone_updated = false;
	local updated = false;

	
	--desenha a imagem
	if(self.tImage ~= nil)then
		img_icone,img_icone_updated = self.tImage:draw();
	end
	
	--desenha o label
	if(self.tLabel ~= nil)then
		lb_icone,lb_icone_updated = self.tLabel:draw();
	end
	
	
	if(self:isChanged() or img_icone_updated or lb_icone_updated) then
		self:update();
		updated = true;
	end
	
	local fundo = BibliotecaAuxiliarDesenho.newImagem(self.largura,self.altura);
	BibliotecaAuxiliarDesenho.limparTela(fundo,self.corFundo);
	
	--desenha a imagem no fundo
	if(img_icone ~= nil)then
		BibliotecaAuxiliarDesenho.desenharImagem(self.tImage.px,self.tImage.py,img_icone,fundo);
	end
	
	--desenha o label no fundo
	if(lb_icone ~= nil)then
		BibliotecaAuxiliarDesenho.desenharImagem(self.tLabel.px,self.tLabel.py,lb_icone,fundo);
	end
	
	return fundo,updated;
end

function TIcon:handler(evt)
	if(self.changed)then
		evt.changed = true;
		self.changed = false;
	end
end

function TIcon:isChanged()
	return self.isAttOrientacaoAlterado or self.isAttTLabelAlterado or self.isAttTImageAlterado;
end

function TIcon:update()
	
	if((self.tImage ~= nil) and (self.tLabel ~= nil))then
		if(self.orientacao == TIcon.TITULO_UP) or (self.orientacao == TIcon.TITULO_DOWN)then
			self:setAltura(self.tImage.altura + self.tLabel.altura + 1 + self.margemSuperior + self.margemInferior);
			self:setLargura(math.max(self.tImage.largura,self.tLabel.largura) + self.margemEsquerda+self.margemDireita);
			
			self.tImage:setPx((self.largura - self.tImage.largura)/2);
			self.tLabel:setPx((self.largura - self.tLabel.largura)/2);
			
			if(self.orientacao == TIcon.TITULO_UP) then
				
				self.tLabel:setPy(self.margemSuperior);
				self.tImage:setPy(self.tLabel.py + self.tLabel.altura + 1);
			
			elseif(self.orientacao == TIcon.TITULO_DOWN)then
				
				self.tImage:setPy(self.margemSuperior);
				self.tLabel:setPy(self.tImage.py + self.tImage.altura + 1);
			
			end
		
		elseif(self.orientacao == TIcon.TITULO_LEFT) or (self.orientacao == TIcon.TITULO_RIGHT)then
			self:setAltura(math.max(self.tImage.altura,self.tLabel.altura) + self.margemSuperior+self.margemInferior);
			self:setLargura(self.tImage.largura + self.tLabel.largura +10 + self.margemEsquerda + self.margemDireita);
			
			self.tLabel:setPy((self.altura - self.tLabel.altura)/2);
			self.tImage:setPy((self.altura - self.tImage.altura)/2); 
				
			if(self.orientacao == TIcon.TITULO_LEFT) then
				
				self.tLabel:setPx(self.margemEsquerda);
				self.tImage:setPx(self.tLabel.px + self.tLabel.largura + 10);
					
			elseif(self.orientacao == TIcon.TITULO_RIGHT)then
				
				self.tImage:setPx(self.margemEsquerda);
				self.tLabel:setPx(self.tImage.px + self.tImage.largura + 10);
				
			end
		end
	elseif(self.tImage ~= nil)then
		self:setAltura(self.tImage.altura + self.margemSuperior+self.margemInferior);
		self:setLargura(self.tImage.largura + self.margemEsquerda+self.margemDireita);
		
		self.tImage:setPx((self.margemEsquerda+self.margemDireita)/2);
		self.tImage:setPy((self.margemInferior+self.margemSuperior)/2);
	
	elseif(self.tLabel ~= nil)then
		self:setAltura(self.tLabel.altura + self.margemSuperior+self.margemInferior);
		self:setLargura(self.tLabel.largura + self.margemEsquerda+self.margemDireita);
		
		self.tLabel:setPx((self.margemEsquerda+self.margemDireita)/2);
		self.tLabel:setPy((self.margemInferior+self.margemSuperior)/2);
	else
	

	end
	
	self.isAttTLabelAlterado = false;
	self.isAttTImageAlterado = false;	
end


--~Gets 
function TIcon:getTImage()
	return self.tImage;
end

function TIcon:getTLabel()
	return self.tLabel;
end

function TIcon:getOrientacao()
	return self.orientacao;
end


--~Sets 
function TIcon:setTImage(tImage)
	if(tImage ~= nil)then
		tImage:update();
		self.tImage = tImage;
		self.changed = true;
		self.isAttTImageAlterado = true;
	end
end

function TIcon:setTLabel(tLabel)
	if(tLabel ~= nil)then
		tLabel:update();
		self.tLabel = tLabel;
		self.changed = true;
		self.isAttTLabelAlterado = true;
	end
end

function TIcon:setOrientacao(orientacao)
	self.orientacao = orientacao;
	self.changed = true;
	self.isAttOrientacaoAlterado = true;
end

