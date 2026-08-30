Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14521E22E9;
	Sun, 30 Aug 2026 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788128531; cv=none; b=HOOoPD5CHY79qWWigA/q9UcDmQEPD3qdgg3oqSFfwN0CHQyFi4ZEKVQKp+3k54TGejKgnozFivzQLP6nHd3SYf41HpBmxLy8UngsSiXY4qjzXH+buxpBjEoKZ3sF5QilSez6tCc4QXOsqtxUSi5PKSkt9l1wiiIL6Z7bDhMzuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788128531; c=relaxed/simple;
	bh=soVu8A2+dtr0lFAXUPb94WfSsoHS1/zzs4k/bk6DsRk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QzCSPNq+vCndopGsVpnDrKaLnLlrzTDiDf4u1usQEROwOWpw3mdoZT5dWqZBA2wQOoEm6yiiuBRSF60jyjchynd0+/RLTbjxq15SR5ZOjsNfAD6RkL+I+1pgvMotuIO5p+0qVmRKRIBVy3JQKyQCo2hXOLZuLTZ0i8LyZPcjS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=f0KsRvXa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KkNGu1N6; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="f0KsRvXa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KkNGu1N6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F4381D00073;
	Sun, 30 Aug 2026 18:22:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 30 Aug 2026 18:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1788128527; x=1788214927; bh=A0WLpSR6ggG5QIfAzGiPLAdjLpbDYZ5h1XM
	la0jr4sc=; b=f0KsRvXa4ifcByDr0Dlh7y77K8gCPdbA1X63UOEkaH8vGOdfDJs
	R8EdOih1wmjafFtIteutadZozpBgq2VceiRrEM8Zm9wVA9S5l8wU3OhdAMcClOEo
	NxDvPjMHnjm2XFAz3+Mid1QDULGHGoDI3dQcLc8uHgpwxJfkTUD3i8DhrGnM72CQ
	Wvr670JfDBIrjOfR0DhTCEtoFDFbJ4fKz2FJQ3MPVjXRNHSPmcbO4NF0p3GQHHKJ
	o543P6yoR6IS4QGqx6uv7Dc+5Xj0FyJzvZA8JVnKf0NlPak6JFVodVj4fWQuqkLL
	MdgZZhw+qOxvVbewABx6g1DRxZciGIERr7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788128527; x=
	1788214927; bh=A0WLpSR6ggG5QIfAzGiPLAdjLpbDYZ5h1XMla0jr4sc=; b=K
	kNGu1N6CqcImdNtM9T8u3Bxvk+OtKeDEr5hcMogT/ssZHtHum3t+qf1030zlJsEr
	MGWY8QmUmDcHMFKfgywgfyYMqeN8XNJoyfMxIp19+gY+s2YlFm4YayaIcRXyPG+T
	G9oVfphvIrIZo35/mbLbVyJX28SeRjkLkhs4k25O8ThaxXJE+BrlIbAluPiAbtAZ
	p38RXTKUpxvqlejOdWRb0SurYA6KK519hWFB1+iIAe8No/oOHRviiAGsg+QHtzxE
	PaGOYptSnFwqyNiILGXWn4qGPzrdb+m6669Qt2a6tPQSzT08IFt6gs4/fuQ+6KdU
	eRLMRRg/Mn7SyxIah1Exw==
X-ME-Sender: <xms:Dq2Uahb0IJWtlQajr0ewmeITL8NNllmofUpe4xE27kUPYCI1bN-reQ>
    <xme:Dq2Uap7bPLj_RlVF-MgNSEaurq-HnwbefyE9klQsW-fYH1Zf1laofE-alfEEB7equ
    FnZimL-EYXYDny5rgwTVl4BXOiQy7w-ts4EvTyLzQDO3S5vwsk>
X-ME-Received: <xmr:Dq2UakAz982WTOKLn6JbiTOCUyl_xNK_j5fWckV7PNpXrYmlxaUF2Mg6uLw80X1bwyPItyzdtND78YYTH-UOcBdEOjdUGGw>
X-ME-Proxy-Cause: dmFkZTFDQRCcvuiFfAbHC/f7FsdtJkQMpNCjEJFLGuNbTyhFRjvt1LX2xEwJONLAGU862f
    Uwk4XVz+7YR5bgdMjgyRMZ7hjGdyLd1OPnHO4nmhl2ritpBnExEhufK5W1b9hAWsRbqms7
    f/YFKI7YGnU8S0Tds44rCQ4HhWGrW/c14nbvZ1KHG3lhIue1h/g+zWgXpdoKDSMIX5GAn+
    7AY3AyRlbhALSA9VWzuIpXEBHi+IZYic3PUr0tN/NjB9BbBozYxIu8wndXDKqPUNGTHav2
    UVxcdPfFyWp9LWRAW/i5NBUsd5RGtS0ZPjxIGCoYuOb4+C1F0D/+cpA8aHXW7v5+dmS/pj
    BLneJrnjnUmgWD9/6vpon92TeM37/mRtjEkzqgWTbTDJZ2/RWz1R5JTjCGOaC2F9lo/Ws7
    CmvjMVbTGCawa1yDK/aTUC7yKHxUOgER7p0CfFb2qCUp9AHyVKr//XOluWL8yhvkdn+5tg
    86l2IGy1u4DB01jVEbXQloaHqmekoCLYuOzVBPoS3Pi6qURYGeP5bxgz+JwinnbE/8vBxQ
    TYkBzWYAZpkx9+bRKcqvGzrrh1SncPzH9QAuVmkAFixaqferviSSSNYxBLO6frLyu4EfvZ
    +nwvY58oMtV0q5pshWxkvWW8MTuq3z1nX1V0A+4pRWO9QgcQnLWKC8sZKUmA
X-ME-Proxy: <xmx:Dq2UaverSI0zQl5IGrfG_I_TIQjHHyBXSb5tyIRvjWjx-sHLfzUVoQ>
    <xmx:Dq2UajJqXoJQUdAzpDhHlK4CgWdgQQUX_gn8S2THhd0cN7OHYNu4Cw>
    <xmx:Dq2Uaq1kJY-xEkE9PWSUrIqVjvXxx_mqXOe0_MSC2pJJMA2R8J-s5w>
    <xmx:Dq2UalimnqkK5n4p6YAQ5XeDHAPMxquR3_OyOomV8r9HeFVGirfY8w>
    <xmx:D62Uav8wjmk6fwDw24uIQ9Z4WYQj7Q3txP7REN8NKxHWGr991M0zAysq>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 18:22:04 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Theodore Tso" <tytso@mit.edu>
Cc: "Matthew Wilcox" <willy@infradead.org>, fstests@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Chuck Lever" <cel@kernel.org>
Subject: Re: [PATCH] fstests: generic: Add test of seek in directories
In-reply-to: <apGfAFkNdD5mrASi@mit.edu>
References: <20260827234743.2389778-1-neilb@ownmail.net>
  <20260827234743.2389778-2-neilb@ownmail.net>
  <apEK5uirjyLZUfmA@casper.infradead.org>
  <178791556100.3510150.18132687067056760170@noble.neil.brown.name>
  <apGfAFkNdD5mrASi@mit.edu>
Date: Mon, 31 Aug 2026 08:22:01 +1000
Message-id: <178812852153.3510150.11411436066299613954@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 29 Aug 2026, Theodore Tso wrote:
> The key requirements come from readdir() and seekdir().  To quote from
> readdir() specification:
> 
>    If a file is removed from or added to the directory after the most
>    recent call to opendir() or rewinddir(), whether a subsequent call
>    to readdir() returns an entry for that file is unspecified.
> 
> And then from seekdir():
> 
>    The seekdir() function shall set the position of the next readdir()
>    operation on the directory stream specified by dirp to the position
>    specified by loc. The value of loc should have been returned from
>    an earlier call to telldir(). The new position reverts to the one
>    associated with the directory stream when telldir() was performed.
> 
>    If the value of loc was not obtained from an earlier call to
>    telldir(), or if a call to rewinddir() occurred between the call to
>    telldir() and the call to seekdir(), the results of subsequent
>    calls to readdir() are unspecified.
> 
> Telldir() is specified to return a "cookie".  It does not have to be a
> offset, and the DIR * returned by opendir() and consumed by
> readdir() does not have to be backed by a file descriptor.
> 
> Historically, jfs implemented an whole an extra on-disk btree in order
> to implement the insane POSIX seekdir()/telldir() semantics.  (Meaning
> every single directory insert or deletion required at least one extra
> disk seek.)  Ext4 returns directory entries in a very sub-optimal hash
> tree order, requiring lots of extra disk seeks, in order to provide
> this guarantee.  This is also something that historically has been
> enforced by Posix Compliance Test Suites (PCTS) for those people who
> believed that Posix compliance was relevant.
> 
> And, yes we also go through all of this pain and performance hit not
> just because of Posix compliance, but also because NFS requires it.
> Personally, supporting NFS is *way* more important than Posix
> compliance, but people of good will can have different priorities.  :-)

Given that the requirements predates the htree design, isn't this "pain
and performance hit" a deliberate design choice?  Or maybe an
unfortunate design omission?  Such things can be fixed.

Presumably as well as the "extra disk seeks" the current design prevents
read-ahead from being effective.

ext4 already has two indexing schemes - indirect and extent-based.  How
hard would it be to add a third that effectively moved the current
directory index blocks out of the "file" and into the "file-index"?
Obviously the 32 block address in dx_entry would need to become a 48 bit
device address etc, and there are bound to be details I've glossed over,
but this approach would amortise all metadata access of a lot data
access, and would allow read-ahead.

So if there is really a problem, I'm sure it can be fixed.

> 
> For this reason, I would support having a test to provide the
> gaurantee needed for Posix and NFS compatibility.  Not for Posix's
> sake, but for NFS's.

Thanks for the support.

NeilBrown
