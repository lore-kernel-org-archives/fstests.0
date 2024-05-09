Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DD1FAA
	for <fstests@vger.kernel.org>; Thu,  9 May 2024 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258482; cv=none; b=eDE0cLbIrTLnc5ErIrDrwia4lc/IXSOs2ruQYAct07kAeOyUiMApJI8j96BTbRGCdW/WU0Q6x0zKDtwaQXwJANsYOtMqHdZhekY5gfYM9TuMwPNm2NFLpJzK4/kalqY6j7T+4J6yBf0YAwG9i7n+/gNSgncOIlrUyyCvkzkHi/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258482; c=relaxed/simple;
	bh=rVs5WagxfOm/ocw4Q31Uld2JCftU4nJGWzVGhnG1UIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GusYyYBf5qwRYcY5sFkdhSb2Zpg4J+ADbkNYv7SE/vvXaWJ2WXuDH60QzPMjFEAsK8v0BYX/ytZelOFn3P9oIjLjMwoVY4I7cgV+XIEUfty+LmD/ODnoQd+pr1WLAiPQ3poxQN7qLV0xbkTNDBIP3tDcsdQ/PymwjAtJqboxUDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vFrk2uOR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vFrk2uOR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6sy1df8lvguNQjEVQBQiyHTJpuKGgAGIRqFF6TAMXpY=; b=vFrk2uORbSlyAfwpZUcoX7KPQP
	WRmeNbhqTLlEx57oVrOb0grWTVAiApZmqERlIGEZEPyjq2nKNdRtwQds1Kc08aDnBY9oV3teJgYCj
	aFRiDODErTY6Y1rGxzzFa9cxI8MEAxzC322FZejhUnPqnKfwZdEW102AVYPMlnIOPqYJTmpkmY/4s
	iEoq5XxZ8IDTl3qabW4B9J5z5bzsodcnIrgg+l3LMsnQV13nvK9CuFsgkFM8o8J6h4HW8gsd16Hz+
	aAOmGrjibDT8769stUzeJAWXWfbWjs5e2HR0ldmsv1bcwVJ657BW5VnJu7MSDlRqU25993K697r2I
	uUeIMsbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s535M-00000001SkM-39MY;
	Thu, 09 May 2024 12:41:20 +0000
Date: Thu, 9 May 2024 05:41:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Sterba <dsterba@suse.com>,
	fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] Move shared/032 to generic/740
Message-ID: <ZjzEcG8Z1_Ly2x-X@infradead.org>
References: <cover.1715108589.git.dsterba@suse.com>
 <8dcb7d564180452eec0c2888740c1b0919e171d3.1715108589.git.dsterba@suse.com>
 <Zjxht5OKsau5QJYm@infradead.org>
 <20240509100016.ov23vek643renv36@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509100016.ov23vek643renv36@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 09, 2024 at 06:00:16PM +0800, Zorro Lang wrote:
> Yeah, that's the reason I still keep the shared as a "prefix directory"
> of generic. The hardcode whitelist or blacklist of _supported_fs is a
> bit rude. If a fs isn't supported by a test case totally, that's fine.
> But if the condition of _notrun can be smaller and more precise (refer
> to some _require_xxx helpers) that would be great.
> 
> Of course we can move shared to generic at first, then improve it later.
> But I doubt if we can keep that in mind, due to there're hundreds of
> generic cases :)

# git-grep _supported_fs tests/generic/ | grep -v generic

will do the job.  But before this turns into an endless discussion
I can just sign up for adding the proper helpers after the merge
is applied.

