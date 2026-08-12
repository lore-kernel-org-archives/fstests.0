Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FDA4307AB
	for <fstests@vger.kernel.org>; Wed, 12 Aug 2026 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552983; cv=none; b=hN65Jpz0KHBpb4V3J8UX9TGs9WYntH5cDLAEqzecaXPTJLkv1/mQOp1dstNQroI/iVn63i4EmD7fipSilUImRySXIepnAg7ygZEGIZQhR3YLVr6bgFVAHHMjDTe+vzAyJfz8umzlpVyJRo/iDgPnJh0cmEHPWd1tJZDTbZyohVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552983; c=relaxed/simple;
	bh=BAmIgq8NbdNj4ZfmdgY5siFmYjraiz4lCgyg2mg+Dhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNsvzkKccyzXWEzClwB7u/tNWKiQt51hnnwC2SuIdkDrqGoBzshD7FozgQ991F8BAY4H9zTEskguf19tI/wv9ZzqrcUanP7JPMwctSD+ydDaw6IqtY1LPieMQCEg/FSxCxITUMvS+1RQ45KRXxJiDqxRoOWG683r6D3L4Mkwc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG/7+obp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG/7+obp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCFD1F000E9;
	Wed, 12 Aug 2026 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552982;
	bh=ZX41/WFGOkEbRhe8/d5AcWf+4W3FoDciL7yeilxpGwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kG/7+obpezatuiKyPDxOHdt1ynAfAfA68LRGOmhaUvUxTd7sXyIdgYKCcZ8tFASb0
	 UGH9lTcBR5BXj/ogMoSZEN7CFwj2y03cpfhwLxav/yneHeMExTtun5ByCqwoC+q+J7
	 sLtOb6RcdK0trimymTgv11nY0Pi1q4kBr4Rkdf82oEwjO1NiyD8R4lQmsnJ92g9TRf
	 4B+JCDT4PDt+q9ItEzJJdnO9xtPo67VzvAphzJDlSiLElCdaop+cqXDGZybzTO5XvB
	 O/r5ztlJGc9Bk9lxxXznP1jePKenLoPV61Ng0fHRsC8s9PYhHfIDTsq14dDLd3T0YV
	 e+XBX19OWT0LA==
Date: Thu, 13 Aug 2026 00:42:57 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] idmapped-mounts: probe O_TMPFILE support with the
 caller's mapped id
Message-ID: <anyG3P9CnAt0ZXUV@zlang-mailbox>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>, 
	fstests@vger.kernel.org
References: <20260731090253.1665192-1-wozizhi@huaweicloud.com>
 <f705ea52-36da-4fdb-a41e-a67a10830919@huaweicloud.com>
 <anoyQqDV_ga7ttCg@zlang-mailbox>
 <20260812-kurzarbeit-unabdingbar-mutter-e31cef822206@brauner>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-kurzarbeit-unabdingbar-mutter-e31cef822206@brauner>

On Wed, Aug 12, 2026 at 11:58:15AM +0200, Christian Brauner wrote:
> On Tue, Aug 11, 2026 at 04:40:18AM +0800, Zorro Lang wrote:
> > On Thu, Aug 06, 2026 at 02:11:55PM +0800, Zizhi Wo wrote:
> > > friendly ping...
> > 
> > Hi Zizhi, actually I'm waiting for the fix from vfs list.
> > 
> > Hi Christian,
> > 
> > Could you please take a look at this issue? Quite a few people have submitted
> > patches trying to fix this test issue. Given that you are the authority on
> > this topic and previously sent a patchset [1] to fix this kind of issue, I think
> > accepting your patch would be the best approach to stay aligned with upstream
> > VFS. Christoph also metioned that [2] last time. I don't want to make this issue
> > fixing any more complicated. Could you please provide your review point or
> > rebase your fix on the latest fstests for-next branch, we'll review it ASAP.
> 
> Just seeing this now.
> Please accept my patch which is a lot simpler imho. Thanks!

Hi Christian,

Before merging your patch, fstests has merged below commit:

  [1cca2bc0d7a9] fstests: vfstest: skip rejected tmpfile creation

I think we can revert this commit, then merge yours currently.


Your patchset below contains 2 patches:
  https://lore.kernel.org/fstests/20260615-overlay-idmapped-vfstest-v1-0-c6b3b2228092@kernel.org/

Patch 1/2 has been acked and contains fix we want I think, so I'll
merge it first. The patch 2/2 remains under review, so I'll leave
that one for you update later. Does this make sense to you?

Thanks,
Zorro
