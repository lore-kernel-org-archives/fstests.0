Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603733;
	b=YSm7T5RARZz3uLyNDQ86mCpDKNTnABQ6I99eux486iVHBGsZq0KBc2IOk7e1UmWHjqnD
	 zdTV/jyP9Ru2D07yWtfsx6fj5qYpJtrim/pFL9BfyHHqtF95V4lbKlYNbppywUSINml4D
	 00J1COSgxQ2fuDSFnOuvOiQ7rm5dYXDZxnQIS93j+jvuRGkdQp8hnyKzCtjkg1ESMf9pd
	 yHhU4XSNd4ZMSjUA3gq2fNKXAs71ReOrdXdE2PtaTicn5gZ6qxp69n0DeH9xIiE6tg/qd
	 DD4AKtf9aGxMOzS4zWpkiBpq9dGhb8PgdhjbziZ3LZSC7SvQtSA9h8mvBPL3Qlv5qpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603733;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GvyhdGcpn4Ds2LSUPbz5bfu9kbGBK2C+7gdZ5Uw4pr0=;
	b=kskLf5IzrAyWDtIo7nxBt35WqZPTCZOub9MzM0+Udd6bVOq4bFARWuQTQjI/BmXZlLzq
	 Aznz482U60zYlPjLYwEs48GapVUB/udfSSOWPQnfmHTDj9Ab8oC6QspmV49Zh0AbdMd9G
	 WOIhYMS4mUJcYfN1NrXUBF9PKLOu2I4xQKgQl68RdBBysv8MXBgoih+vxjYAwVtE6CrWu
	 MJ0u+9JxWHdt68eEGbkDnhycHswESizPW/4vu9xFAXRcMJM683/q8IFOXSvF33CE8nqyl
	 rS15k68bc4uGbPh0N7rPisCsF+FsxY6j9nKbjwd38Dm0iCcCmRNUSExXQxyE9Gjc9bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PagfCyWy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DA6606A321
	for <fstests@vger.kernel.org>; Wed, 25 Nov 2026 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PagfCyWy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F811F000D4;
	Wed, 25 Nov 2026 10:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795603732;
	bh=GvyhdGcpn4Ds2LSUPbz5bfu9kbGBK2C+7gdZ5Uw4pr0=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=PagfCyWyISiQjOAFf3NGAWh2Sust5qDxnokK0tr10uOMjTY2tSV8B3yZBpSZDVlZ7
	 s24K/Xg22l4LGOZSmQw59MTwFd46FQlt1FuCL3gnx+mZ8nKiIWOiCwaW1x0uIqNA+p
	 7avkq5dCDllBu/VUXRa/0SqSUI4BVuMBlPnEV6QTNep8kqL7PSiO76glI+DW57ODqt
	 kuDKN0XBiOSvsNnQTlXW8zxrxzZ3O6LDZrcZPRSzIedrwPPrdUZ/ZnTTVepr4Cppiv
	 IiUDnVzQj/lF70cP2w+2PIgADoXb8/73vNw+wn41RSdEgPPZaaEd5Ug85TqAr1cGy9
	 apm+ULg/FbFYQ==
Date: Wed, 25 Nov 2026 11:48:48 +0100
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests <fstests@vger.kernel.org>, preichl@redhat.com
Subject: Re: [PATCH 2/2] xfs/349,xfs/556: both these tests require online
 repair in the kernel
Message-ID: <awa6F8rKj-4xD-eF@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20261124103617.4012647-1-aalbersh@kernel.org>
 <20261124103617.4012647-3-aalbersh@kernel.org>
 <awXw0TF3yf7pM_f-@zlang-mailbox>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awXw0TF3yf7pM_f-@zlang-mailbox>

On 2026-11-25 04:20:46, Zorro Lang wrote:
> On Tue, Nov 24, 2026 at 11:36:15AM +0100, Andrey Albershteyn wrote:
> > Both these tests run xfs_scrub without -n (scrub only, no repair),
> > therefore, scrub tries to repair found issues. However, without online
> > repair enabled in the kernel scrub exits with a message that online
> > repair is not supported, breaking the golden output.
> > 
> > In the xfs/556 case, online repair will not repair anything but just
> > prints a message that unrepairable issue found.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  tests/xfs/349 | 1 +
> >  tests/xfs/556 | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/tests/xfs/349 b/tests/xfs/349
> > index a03ab812dc9e..0940ced42121 100755
> > --- a/tests/xfs/349
> > +++ b/tests/xfs/349
> > @@ -18,6 +18,7 @@ _register_cleanup "_cleanup" BUS
> >  
> >  _require_scratch
> >  _require_scrub
> > +_require_xfs_io_command "repair"	# online repair support
> 
> As neither of these two cases explicitly runs xfs_io -c "repair", I think
> the comment could briefly mention why the online repair command is needed,
> to prevent it from being accidentally removed in the future.
> 
> Thanks,
> Zorro

This could be probably be better wrapped into
_require_xfs_online_repair then?

-- 
- Andrey
