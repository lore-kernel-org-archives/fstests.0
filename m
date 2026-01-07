Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEDA28541A
	for <fstests@vger.kernel.org>; Wed,  7 Jan 2026 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774319; cv=none; b=rOjgFn6W5O3aUsWVQOiXWfAYXI4cziBCuot0Mv/C1+f+jZoZ4KoqL6vxtPWuWXhFptT9JyC+ap4dJr6IKGappxT7jwsiyiuh8Xtbph4OUObKsDc7RSi/pfcNRjsWm0w+umZyc3cSiR8CbpNTuD7zgcdIDpByp3L5CwkQh3KsGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774319; c=relaxed/simple;
	bh=yD62lNwoKN0Ax5tyicdd75jIYYnJQic6nCt+7sqpvY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7VFQBPj3nc499IY7W0x3qnR2ifznPOBg38q8gAPoW6PZHc3knb4bqScPYCjcmj3CWbGNP2G++9ZoRQzMHsRZPYHTAGoug54u6Rthdkbfu/xLlNUGGNrj/dCTh2JAY8qh4BnpDsglaIoCBTNAvuuJX+y6xW7V6BX3Hw64mwxZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mjHdl5Nu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mjHdl5Nu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yD62lNwoKN0Ax5tyicdd75jIYYnJQic6nCt+7sqpvY4=; b=mjHdl5Nuq61pEm908gpQxIKEqY
	Bz75jQBLuyLhGzOJRcnXC67SQMUHlCPnYsTl0/lzHvbOQOkBrC4Bsp4o0hTI3r4AXPWlfhDjif0G9
	/ccuwLo7UMhhiJMzR04X0uFJaG7EdGOWYaUashtR8BPyNIWuHslLBXwpVOTxOIjQmY0RCfPIcQoZz
	5UuKfPOFFAjs3cnjvWuairaKMw6+J1Da7tBrHXMnVnFJP0u0JrWww+LTUq+1YRo87Q+8WsQMlNemR
	oJamILoNM+oIV++2KxVuego4eGAu8s7drmjNrEqsMmMssdabgFlHAkFjpwQAAUiR3Tt9g68++fWAD
	74Q8EbIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdOqx-0000000EP5J-4AiT;
	Wed, 07 Jan 2026 08:25:15 +0000
Date: Wed, 7 Jan 2026 00:25:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Shahar Hochma <shaharhoch@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] t_readdir_3: Allow EOF on ignore_error
Message-ID: <aV4Ya2OyhzF0BwdY@infradead.org>
References: <20260104102816.1542861-1-shaharhoch@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104102816.1542861-1-shaharhoch@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Jan 04, 2026 at 12:28:16PM +0200, Shahar Hochma wrote:
> ignore_error is used when providing random input to setpos.
> This can, by chance, produce a valid response from readdir,
> but with EOF. In which case, we don't want the test to fail.

Just curious: how did you run into this?

