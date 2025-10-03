Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E36F2C236B
	for <fstests@vger.kernel.org>; Fri,  3 Oct 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509754; cv=none; b=hroGfmB6xFMONNpnBRGEh1xbOmRd9HCQCB4OgEzJVO7izqPCiCUVqxbnOXjmp1lTa2r9KPKyj/0Rj/Ffd6d41IxusLAHrxh/oSIvpSz91OEkJC4O8F5wM5H1ZlGHpDPVWqUjHdnLPSFEsC1pt/aKD648DmlQQNFzYJYZ0KtuDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509754; c=relaxed/simple;
	bh=2vM9WbBxLoiNuv/ifCy0fu4bZYJPwZhrOYJXYV+rIOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP+jjmZ1O47qwJS63qfql6j6so5xsARoMNe+Oq/jPtRiC8Sat9kzAxss0yoZekrXSQ2qQtJ5qk646ZXSuCHLjdD2FYa1qenA9bOcCxtAKMes4iVbjOKs3TxRr04lNy8QWjmqqVwiHdIlzT7+ep2dWvXmYAAs2G9a7HZZ9qr759k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVIn6FBV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVIn6FBV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACB6C4CEFF;
	Fri,  3 Oct 2025 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759509751;
	bh=2vM9WbBxLoiNuv/ifCy0fu4bZYJPwZhrOYJXYV+rIOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVIn6FBVKBz4QYlzib5FZIUskpCeUR60qSL+NRIAHbT6RlQt3E0INPErmauR504q+
	 L3NeFivZaFMX3TwmCI3lwvQC+sH2900k2mlQnkwl8cQy1LZK5ar4AYct0Aj7z46m/O
	 X8D1Jva2J6KrmD3XA5Gsmzz3V944UyqHzQvdz/4gEKLKQ4YMwtO0NrUbB4pG3/os5X
	 yyorYwivaV1hORnhPBjwua3eWeHx4abtdRi05aIxAT+uzo43u2snqHRAklrd+s5Ydu
	 dChvjFg7XG8D/PniCji1PTdTR5348ZLm1C6lZK+cDThyfCplKLeRgwdS9QcnJtbiZp
	 xyO9+0BSmpzLQ==
Date: Fri, 3 Oct 2025 09:42:27 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>,
	fstests@vger.kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 1/1] common/encrypt: Do not run
 _verify_ciphertext_for_encryption_policy on compressed FS
Message-ID: <20251003164227.GA1649@quark>
References: <20250915100451.810719-1-jprusakowski@google.com>
 <20250915100451.810719-2-jprusakowski@google.com>
 <20250915143951.GB1993@quark>
 <CAHwWncjUFzByau+oWh--Q3t-w6FjQ8kWG_fiOyEzLB=HHfdAsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHwWncjUFzByau+oWh--Q3t-w6FjQ8kWG_fiOyEzLB=HHfdAsg@mail.gmail.com>

On Tue, Sep 16, 2025 at 02:13:39PM +0200, Jan Prusakowski wrote:
> On Mon, Sep 15, 2025 at 4:40 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Mon, Sep 15, 2025 at 12:04:51PM +0200, Jan Prusakowski wrote:
> > > common/encrypt: Do not run _verify_ciphertext_for_encryption_policy on compressed FS
> >
> > A better title would be something like
> > "common/encrypt: Explicitly set the test file to uncompressed".
> 
> Agreed, will fix that in v3.
> 
> > > @@ -790,6 +790,13 @@ _do_verify_ciphertext_for_encryption_policy()
> > >       _set_encpolicy $dir $keyspec $set_encpolicy_args -f $policy_flags
> > >       for src in $tmp.testfile_*; do
> > >               dst=$dir/${src##*.}
> > > +             # To make sure the test file is not compressed we create an empty one
> > > +             # and disable compression first (F2FS won't allow resetting the
> > > +             # compression flag if the file has data already in it).
> > > +             touch $dst
> > > +             if lsattr $dst | grep -qE ".+c.+ $dst" ; then
> > > +                     chattr -c $dst
> > > +             fi
> > >               cp $src $dst
> > >               inode=$(stat -c %i $dst)
> > >               blocklist=$(_get_ciphertext_block_list $dst)
> >
> > Is adding 'm' (FS_NOCOMP_FL) needed too?  If not, why does it exist?
> 
> In my setup files created have FS_COMPR_FL set from the start. Just clearing
> FS_COMPR_FL appears to help as now all the tests using
> _verify_ciphertext_for_encryption_policy
> pass when I run them on f2fs with "-o compress_extension=*".
> 
> Do you think we should add 'm' (FS_NOCOMP_FL) as well just in case some other FS
> behaves differently? Do you have any ideas on what other FS I should check?

I think so.  It doesn't look like f2fs does anything with FS_NOCOMP_FL,
other than enforce that it's mutually exclusive with FS_COMPR_FL.  But
there could be filesystems where 0 gives the default behavior (which
could be compress) and FS_NOCOMP_FL is needed to disable compression.

btrfs might do that, actually.  It doesn't support encryption yet,
though, so these tests can't be run on btrfs.

I would just add FS_NOCOMP_FL and make sure it still works on f2fs.

- Eric
