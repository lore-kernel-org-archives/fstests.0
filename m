Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218EE30C16E
	for <fstests@vger.kernel.org>; Fri, 17 Jul 2026 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308265; cv=none; b=B25urGEd7oFo1rMZ1Ua3WS9nnVnENuGwHvp46hvLU96sv49fqfKWFelEUo0yCEb9emYo/iZ1pduxK+am4UCuCzlSAtMmqiOSl/usWXMQPO48x3NvWLvycFudQTJblIuXRbKkutS4ES3fKzC7Cu3fe6ZHDnvn8/ydcJtZwy6oXJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308265; c=relaxed/simple;
	bh=O82F+W1qVLUDjnPjs3YZUrbT5NyxmslGH3HtBT+HQG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPwGqCASdqjooykhvQVVaUe+4fguqQ/YiZqXt7bccCBn78+pXXbnbcfBpgNET+ThAQSIcMEqJLtpHkWMEqjnEEb1caheaJZX/IDBnq7aLLFRP2nvMXiMqZ4IVRtZrCyDpv5V7ldfCBsbH62mCDgeGhichtNNkV8VeqpqiFw0Gw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i++FoDDF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i++FoDDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4D11F000E9;
	Fri, 17 Jul 2026 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784308263;
	bh=GPJE7uw+oaqqVWcKNKIt3u7RtbN/OAMrEe/Y6g7VnR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i++FoDDFiYzx+t0xQ3zIBtWqFM5MM3V/V4jT3eTt/HciGTrzcUbC6A4LKux4k9WaQ
	 GhsTh43vUNrB9bm1Ho3DUhx+f11pPzfra8h3XmcUBJnweTTB3YMADv6GktfbdxwE84
	 pZCjMMVSX7rD1E5nQoeLDW96cBk7XZdSGzfj0tv/o2LewMrBsUDVDehKA5nnsBgld5
	 8DYV6K+CDad+2+a7jPqWMSI9kXYJ5U11lzKQroL7Lsv+1BKxsWW7uElvVmM808RQGM
	 Me+Pg7ManiZmgbwUNrRHE40TfPM1LkCu4RAZVPf2vOuoZ/nnYutbp3zf/vFG3urfAa
	 y7T7ZMwR7VaKQ==
Date: Sat, 18 Jul 2026 01:10:57 +0800
From: Zorro Lang <zlang@kernel.org>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/062: filter setfattr --restore symlink-safety
 warning
Message-ID: <alph7vbbkV3SRCtJ@zlang-mailbox>
Mail-Followup-To: Avinesh Kumar <avinesh.kumar@suse.com>, 
	fstests@vger.kernel.org
References: <20260706061102.90603-1-avinesh.kumar@suse.com>
 <20260706191326.122555-1-avinesh.kumar@suse.com>
 <alnu6gq9a1bJJF8b@zlang-mailbox>
 <bbcbd145-47eb-4336-b9e2-588b68cdb41b@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbcbd145-47eb-4336-b9e2-588b68cdb41b@suse.com>

On Fri, Jul 17, 2026 at 02:04:20PM +0200, Avinesh Kumar wrote:
> Hello Zorro,
> 
> Thanks for the review.
> 
> On 7/17/26 11:22 AM, Zorro Lang wrote:
> > On Mon, Jul 06, 2026 at 09:13:26PM +0200, Avinesh Kumar wrote:
> > > From: Avinesh Kumar <avinesh.kumar@suse.com>
> > > 
> > > attr 2.6.0 (CVE-2026-54371 fix)[0] makes "setfattr --restore" warn when
> > > used without -P and the dump contains a symlink, which generic/062 does.
> > > The warning leaks into the compared output via the setfattr() wrapper
> > > and fails the test. Adding -P isn't portable (older attr doesn't have it),
> > > so filter the warning in the wrapper instead.
> > > 
> > > [0] https://cgit.git.savannah.nongnu.org/cgit/attr.git/commit/?id=3fb06b9ba314d37035d0877e6de313de754f1ac8
> > 
> > For generic/062, modifying the g/062 itself seems fine and logical, as
> > _extend_test_bed() explicitly introduces complex symlink paths for
> > testing purposes.
> > 
> > Have you run xfstests on XFS with attr 2.6.0? There are quite a few
> > setfattr --restore invocations in common/populate. If those also trigger
> > the new unsafe restore warnings, we might want to consider introducing
> > a helper function, such as _setfattr or _setfattr_restore to handle to
> > -h and -P things.
> > 
> > Reviewed-by: Zorro Lang <zlang@kernel.org>
> 
> I am sorry, I forgot to reply to my patch here. I got same feedback from
> Darrick when I sent patch for xfs/083 for the same issue. So this is
> being handled with a wrapper. Please review here and this patch can
> be ignored -
> https://lore.kernel.org/fstests/9b95ab03-34c0-4d2f-b4d7-fdb9c8cbb193@suse.com/T/#m3bef5e49d3ca17f845a3ccab8b6dea5b67c00d86

Great! Darrick gave you a similar review point, I'm going to check that new
patch.

Thanks,
Zorro

> 
> 
> Regards,
> Avinesh
> 
> > 
> > > 
> > > Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> > > ---
> > >   tests/generic/062 | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/generic/062 b/tests/generic/062
> > > index 89659040..ddf0a478 100755
> > > --- a/tests/generic/062
> > > +++ b/tests/generic/062
> > > @@ -30,7 +30,12 @@ getfattr()
> > >   setfattr()
> > >   {
> > > -    $SETFATTR_PROG $@ 2>&1 | _filter_scratch
> > > +    # attr >= 2.6.0 (CVE-2026-54371 fix) warns that "setfattr --restore" without
> > > +    # -P/--physical is unsafe because it can traverse symlinks. Older attr does
> > > +    # not accept -P, so just filter the warning to stay version-agnostic.
> > > +    $SETFATTR_PROG $@ 2>&1 | \
> > > +        sed -e '/^Warning: option --restore=file is unsafe without option/d' | \
> > > +        _filter_scratch
> > >   }
> > >   _create_test_bed()
> > > -- 
> > > 2.54.0
> > > 
> 
> 
