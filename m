Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BBCB66E
	for <fstests@vger.kernel.org>; Sun,  8 Jun 2025 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749386146; cv=none; b=OLFn/+/QTmJwspj91A+MFUA3GUgtWrM+lP1Ay7dx7Hc/Gr6AOyVNnRq5MD5XB50SNa774RvDK+GvYMobhLla/ZY7wRodEwmChrWX44FqgXlXb28UBFOSxtEZsNEoteGXpPizZ+kKRiq258FAg6b7gqjUPuHO/KQRGNbnWXOCKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749386146; c=relaxed/simple;
	bh=/dXDwD9c9e8K4uD6TABY7VOGZAKQiSYHFHx66rJnTcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jr6XchNRYBX2k2RJM/WPC/Siso0QFub28/fCSLnYxbHr4YdNV9SBeCzbYXi6pdxKts+MI28+j0NIb2ja3R3x0OQoxDacnFiE+BwoRucneU41B/3WxlRXy0FnSpdnBodcHXPdbMaP5LDsgHB0Ja4IbNhlweah5Qtnoa7+Gft0Ook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQ8Ksmdh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQ8Ksmdh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749386143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nyh101ASlbwECNUhgUeKqsoWEBRRF+mEQ1Rp5ar6Jlo=;
	b=IQ8KsmdhVrxoxcP73roFVrqeF+huM96EK7Pgg9ybjbR9xDuzbA5H3qTyUCmQbIyiY5YX0O
	XGNqUynIsjx38M/+zv4yETcGxF9qn3m62LvWtCjBv3f8oZGnVX8ZzfGhONAEs9EsJN1Gh/
	omSzAmRyDkOfEb4DQ6jszN0B6g4nutM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Al1MpH-GNa222UAAG8p9CQ-1; Sun, 08 Jun 2025 08:35:39 -0400
X-MC-Unique: Al1MpH-GNa222UAAG8p9CQ-1
X-Mimecast-MFC-AGG-ID: Al1MpH-GNa222UAAG8p9CQ_1749386139
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31315427249so4125828a91.1
        for <fstests@vger.kernel.org>; Sun, 08 Jun 2025 05:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749386139; x=1749990939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nyh101ASlbwECNUhgUeKqsoWEBRRF+mEQ1Rp5ar6Jlo=;
        b=VJ65U6i7QmZevmcBxVxuDqr6+wNPy0jztgy/R0mvK7ybgRY9IczJ3CupmK4zF4PYzj
         14vLttHzgeA8KBObTuMGPcchS9XGZ8psB/zs+10dowgjVZ1Co+n3cGl05gy+HFqbERWu
         fy6XiIvsqRT3V+v/TmWH9n4nssFxwR3GrpyDbS+7RjuGoElSxWSlyWbXbGVLUfJBoW44
         ehkWJ8K7GpGB4oqwTWeirsmr6QW8yilI/p23TojRzfYonmWLNKH9u/SRtYF9MJ49jMj5
         e6U6/7NXtvtCSX3pOeag6EOwJ6K8CHXGLqQso+xvMWNXFmYWZ1O3CCheFr+ZE2b0wOS7
         ck3g==
X-Forwarded-Encrypted: i=1; AJvYcCXf6FlhLM3f61ykeggcYykzR+mvonky4zfBpRCBo4CtdSK/0bqGMAFfDK4e81yfeh/srCYDx/39@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5cnLvVTer/p0SD4nmY7j0FJzYcLmO4CMrkYDSHSMh2UFFlu7Z
	XXmf1774Dsl2vuBW3S/ugmUKHYE+3FrXR7Q8U1qmUnhAQg+LAjgjnHfZSMZER6X6S/l0ENrlWzN
	kR3/lsxrtX0RUUhK952QtlE6yVu+bTqgfVVw3eMjnGwYIlmZ+ukhdzmvfids=
X-Gm-Gg: ASbGncuZ8te6rz7rYRgo63Ik5gxNNOGBm6MJ7ahfn60zin8CtBOYTnRlg5xkcJRuKkk
	vvVghgKvuaY383Yf/K9r6RO+/2yYklGI7MEGcVqdZuLCA+G3ztARSd9fudx/ia9iQCh2B/6xbY/
	3PmPZDaMtYGayqIus/ne+FI/HDi4ndGpRjeWWScnazt0nUfly03jZ438eKZD/ShsZxRHglSaQB7
	RXPnSpjVl0Gvyed3VrkYFPpBJHndmZYSfM1IFELNRNZZHwgTrbGCkH1/inDAzhmiUmvRmU5qcl0
	aJ1yAdDnbu1Xrt4IBaWZY61Y8Ryuo3no1/pUjSQ4Zxs56I5dRf58DZTw3M0q8Ss=
X-Received: by 2002:a17:90b:164a:b0:301:9f62:a944 with SMTP id 98e67ed59e1d1-3134769f73dmr14967409a91.33.1749386138795;
        Sun, 08 Jun 2025 05:35:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgRvnPyG9BoTqzDIt/6nRk1DxN+1hhnE8n1De8r7EAlZn6BDSUVuHtJEh2F4Szeyv8HKjqdQ==
X-Received: by 2002:a17:90b:164a:b0:301:9f62:a944 with SMTP id 98e67ed59e1d1-3134769f73dmr14967386a91.33.1749386138422;
        Sun, 08 Jun 2025 05:35:38 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b13b45dsm4360147a91.37.2025.06.08.05.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 05:35:37 -0700 (PDT)
Date: Sun, 8 Jun 2025 20:35:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: Amir Goldstein <amir73il@gmail.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"Friendy.Su@sony.com" <Friendy.Su@sony.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v1 7/7] generic/633: add test requirements
Message-ID: <20250608123533.zdl4ehn265alpqei@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-8-Yuezhang.Mo@sony.com>
 <CAOQ4uxihwu9-rqFEUboDaDV9onaip4N5QsbdU_xTZQ7MnBDCzA@mail.gmail.com>
 <20250605141757.wx45cw2f5ets7hpr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <PUZPR04MB63167B990F5D144392C67EDD816EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PUZPR04MB63167B990F5D144392C67EDD816EA@PUZPR04MB6316.apcprd04.prod.outlook.com>

On Fri, Jun 06, 2025 at 02:31:52AM +0000, Yuezhang.Mo@sony.com wrote:
> > On Wed, May 28, 2025 at 12:56:55PM +0200, Amir Goldstein wrote:
> > > On Wed, May 28, 2025 at 11:15 AM Yuezhang Mo <Yuezhang.Mo@sony.com> wrote:
> > > >
> > > > Since the following test requirements are required by the following
> > > > sub-tests, this commit adds them to this test to avoid failures on
> > > > filesystems that do not support them.
> > > >
> > > > requirement | sub-tests
> > > > ------------+-------------------------------------------------------
> > > > hardlink    | hardlink_crossing_mounts tcore_fsids_mapped
> > > >             | tcore_hardlink_crossing_idmapped_mounts
> > > >             | tcore_hardlink_from_idmapped_mount
> > > >             | tcore_hardlink_from_idmapped_mount_in_userns
> > > > ------------|-------------------------------------------------------
> > > > symlink     | protected_symlinks symlink_regular_mounts
> > > >             | tcore_create_in_userns tcore_symlink_idmapped_mounts
> > > >             | tcore_symlink_idmapped_mounts_in_userns
> > > > ------------|-------------------------------------------------------
> > > > chown       | hardlink_crossing_mounts rename_crossing_mounts
> > > >             | setid_binaries sticky_bit_unlink
> > > >             | symlink_regular_mounts tcore_acls
> > > >             | tcore_hardlink_crossing_idmapped_mounts
> > > >             | tcore_hardlink_from_idmapped_mount
> > > >             | tcore_protected_symlinks_idmapped_mounts
> > > >             | tcore_rename_crossing_idmapped_mounts
> > > >             | tcore_rename_from_idmapped_mount
> > > >             | tcore_setattr_truncate_idmapped_in_userns
> > > >             | tcore_setid_binaries_idmapped_mounts
> > > >             | tcore_setid_binaries_idmapped_mounts_in_userns
> > > >             | tcore_setid_binaries_idmapped_mounts_in_userns_separate_userns
> > > >             | tcore_sticky_bit_unlink_idmapped_mounts
> > > >             | tcore_sticky_bit_unlink_idmapped_mounts_in_userns
> > > >             | tcore_sticky_bit_rename_idmapped_mounts
> > > >             | tcore_sticky_bit_rename_idmapped_mounts_in_userns
> > > > ------------|-------------------------------------------------------
> > > > chmod       | protected_symlinks
> > > >             | tcore_protected_symlinks_idmapped_mounts_in_userns
> > > > ------------|-------------------------------------------------------
> > > > io_uring    | io_uring io_uring_userns tcore_io_uring_idmapped_userns
> > > >             | tcore_io_uring_idmapped_unmapped
> > > >             | tcore_io_uring_idmapped_unmapped_userns
> > > > ------------|-------------------------------------------------------
> > > > mknod       | tcore_expected_uid_gid_idmapped_mounts
> > > >
> > > > Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> > > > Reviewed-by: Friendy Su <friendy.su@sony.com>
> > > > ---
> > > >  tests/generic/633 | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/tests/generic/633 b/tests/generic/633
> > > > index f58dbbf5..e19a2043 100755
> > > > --- a/tests/generic/633
> > > > +++ b/tests/generic/633
> > > > @@ -13,6 +13,12 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
> > > >  . ./common/filter
> > > >
> > > >  _require_idmapped_mounts
> > >
> > > Please note that the requirement above is wrong:
> > >
> > > https://lore.kernel.org/fstests/20250526175437.1528310-1-amir73il@gmail.com/
> > >
> > > > +_require_hardlinks
> > > > +_require_symlinks
> > > > +_require_chown
> > > > +_require_chmod
> > > > +_require_io_uring
> > > > +_require_mknod
> > >
> > > I wonder if it makes more sense to have a collective check for all (or
> > > most) of the above,
> > > e.g. _require_vfstest, which is different than _require_idmapped_mounts,
> > > so that we do not have to add all of these for tests running
> > > other vfstests subtests in the future.
> > 
> > Yeah, and some _require_ looks optional, e.g. _require_io_uring, why is it a
> > necessary requirement, we even run xfstests with io_uring. If so, we don't do
> > vfstest if io_uring isn't supported?
> 
> OK, I will removed '_require_io_uring'.
> 
> > 
> > Although we can add as many as possible _require_* checks to a test case, but
> > more _require_* take more time to run. So I think we'd better to add "missed"
> > _require_* for specific test failure on someone fs, not only "I reviewed the
> > code, so I feel all of these are needed"
> 
> Do you mean we should check these requirements only for some specific fs?
> Like this.
> 
> if [ "${FSTYP}" == "exfat" ]; then
>       _require_hardlinks
>       _require_symlinks
>       _require_chown
>       _require_chmod
>      _require_mknod
> fi

No, of course not :)

I mean if one case *can* have 100 _require_ conditions in theory, we don't need to
write all 100 _require_ conditions.

As you've removed _require_io_uring, I hope you can make sure if there're more
"optional" _require_ conditions. On the other words, if there're some tests
might be run or might not (likes io_uring).

Thanks,
Zorro

> 
> I think this is not good, firstly because it is hard to maintain(other fs may also
> need these checks), and secondly because checking these requirements does
> not take much time (in my environment it takes less than a second).
> 
> 
> 

