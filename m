Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AEA1A275
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749133089; cv=none; b=ndV8Qxv75ndQGhSbZpIXPT274smJBQ2wHXCdU58hp4MMOkUs93UD23Bdnra5XcHdShr4vpq6ksiWuT4mVdfRPN++Z3gwiRP+b3CqRmDXMWLSU9sczpH65tFkIpKGqnJ4cN09pxmqKh10YHE8Mfp5jarpuiy99htxRLAn9R+3oeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749133089; c=relaxed/simple;
	bh=NMg9cThkKLmpcwPEGy8le0UzxaTHst7+0ZVptWUX1GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gT75EZVMhZzHiEM4GKZqvnPqkQqKgXBBjkY6OA4V5NrRU9SONR6xqDCkAoCJSPxRBNqmU/NaaL1CW8BE2N9dBtGwUqDuarGu/E1jXGdbxnxkufdwp1BmNmpm4mGnHIveitnY5HfUBsA7LljorBlYTQtxJ/Z9d8wY11eYslvasq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GY9AOqzK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GY9AOqzK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749133086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvAWV9fer/2bbKuMES3HMuRaVbD4On8iGMMo0kgNx9g=;
	b=GY9AOqzKtUXnVlSkYag11qDhlH4M4qPQ8EFvGdNBILWJBWvUe4yW4+04yp1goG8GIdDS7p
	sL0YY17UIvIvYwrpGN1xozf4lztI4eq2UjJhWQxObjfkcOi3s0BKKKxhzcNBHA3NdM6T41
	a1o+7Ee1J3sUAVJsM3d8yTBmu2d6u3Q=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-GKCv7eEFPPGyR_81MsffUA-1; Thu, 05 Jun 2025 10:18:03 -0400
X-MC-Unique: GKCv7eEFPPGyR_81MsffUA-1
X-Mimecast-MFC-AGG-ID: GKCv7eEFPPGyR_81MsffUA_1749133082
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b240fdc9c20so1099692a12.3
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 07:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749133082; x=1749737882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvAWV9fer/2bbKuMES3HMuRaVbD4On8iGMMo0kgNx9g=;
        b=W880JnrXAbkOlnJTP83mPUB3+i4JXwxYI8hvSFmuNVwAWURnhYfeub2GuiOd5MyJgC
         5WmAyrdu26FXx0/X3aQtNjnQS1S82lCJo4ADv4xdUTDnuwjLqUun8/NwcfQd/MyEc33K
         tD5BFIrYnv4L2EFztNTEF6zEz9ff8Oy+oKPzpOYY8wAaqe1KRgTp8GhQ+cob9hhKBY9r
         ifJy5hrhnTbos8hBZGjv0u84DmgGwXMC1Wg3kFy2jpMsLe+DFvsjIcrqQVZ3G+eJIl7y
         TOMFoC4XCtOFmTagFNh8qbT+gu5sQxzuZcLQ23F0/EPaBXxQfraTtOwGRqPlYBzI39d/
         xzew==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+a+KIB3HQDOfQEzaZnZ2uQ5fiRhc7NiDOsfBftRnKoVn/xRX54C7WvI3zML5vqnJAnHl/k9n@vger.kernel.org
X-Gm-Message-State: AOJu0YyKCgP1uwfRVAOP2ZhB4C4YrrSohtpXas7oUoDw3b5SubsufMaw
	++LR2Vjxui9Qlsj/GEf5FSvA/XEZMFfmQWXGtMME/iN+19Ad0jgkfZpGCM0UmoICX1vyC0rt5KS
	JRFGm1ueXnDkoxloAhM/eQMW8B9devEewnE9aYvpGqX8gYme4daH4pkpgr4M=
X-Gm-Gg: ASbGncsHJ0FRwXjd1sKw7W+6/Sl3X6Sm+aOO5VL1Ac+7R9jsptx30pYAmcKslH4Vd1d
	ad696GrrVuxSNL2nA4Wsi3FhLneh0/lITinx1hcQ9sd6SyrfxKfbjIE+XaH1WD9JW1KYdsrxmXS
	8HLTf4AmV4kMGc9xBcrRdrYrIKO7QIGmovGMJeGllolUvu7zcGhZHcuoh1QMrk92kza71fQNQJa
	U6PT9Pu42RzAydoGjK68rS/1oG2T6Y+jLVLL/sdxwjz4oRbZsNYbQs6dACDWAE2ZxbUQh1DxGGS
	um9CSZPzBQiS7/VDChhLvlal9I/Vdv0yCpkWVOPAbXlp2ap+onb6EiYJtiyd0Y4=
X-Received: by 2002:a17:903:2291:b0:235:779:ede3 with SMTP id d9443c01a7336-235e11ebbdbmr108518595ad.41.1749133082366;
        Thu, 05 Jun 2025 07:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQrvOP/tUn0pR+Mj47uCFavfe3Lc6A3nsBuTDXjfuJlPBfTky3m7yfog1c7u8KQZoyT9U/mg==
X-Received: by 2002:a17:903:2291:b0:235:779:ede3 with SMTP id d9443c01a7336-235e11ebbdbmr108517905ad.41.1749133081701;
        Thu, 05 Jun 2025 07:18:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf53b5sm120213395ad.176.2025.06.05.07.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:18:01 -0700 (PDT)
Date: Thu, 5 Jun 2025 22:17:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: Amir Goldstein <amir73il@gmail.com>, fstests@vger.kernel.org,
	friendy.su@sony.com, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v1 7/7] generic/633: add test requirements
Message-ID: <20250605141757.wx45cw2f5ets7hpr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-8-Yuezhang.Mo@sony.com>
 <CAOQ4uxihwu9-rqFEUboDaDV9onaip4N5QsbdU_xTZQ7MnBDCzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxihwu9-rqFEUboDaDV9onaip4N5QsbdU_xTZQ7MnBDCzA@mail.gmail.com>

On Wed, May 28, 2025 at 12:56:55PM +0200, Amir Goldstein wrote:
> On Wed, May 28, 2025 at 11:15 AM Yuezhang Mo <Yuezhang.Mo@sony.com> wrote:
> >
> > Since the following test requirements are required by the following
> > sub-tests, this commit adds them to this test to avoid failures on
> > filesystems that do not support them.
> >
> > requirement | sub-tests
> > ------------+-------------------------------------------------------
> > hardlink    | hardlink_crossing_mounts tcore_fsids_mapped
> >             | tcore_hardlink_crossing_idmapped_mounts
> >             | tcore_hardlink_from_idmapped_mount
> >             | tcore_hardlink_from_idmapped_mount_in_userns
> > ------------|-------------------------------------------------------
> > symlink     | protected_symlinks symlink_regular_mounts
> >             | tcore_create_in_userns tcore_symlink_idmapped_mounts
> >             | tcore_symlink_idmapped_mounts_in_userns
> > ------------|-------------------------------------------------------
> > chown       | hardlink_crossing_mounts rename_crossing_mounts
> >             | setid_binaries sticky_bit_unlink
> >             | symlink_regular_mounts tcore_acls
> >             | tcore_hardlink_crossing_idmapped_mounts
> >             | tcore_hardlink_from_idmapped_mount
> >             | tcore_protected_symlinks_idmapped_mounts
> >             | tcore_rename_crossing_idmapped_mounts
> >             | tcore_rename_from_idmapped_mount
> >             | tcore_setattr_truncate_idmapped_in_userns
> >             | tcore_setid_binaries_idmapped_mounts
> >             | tcore_setid_binaries_idmapped_mounts_in_userns
> >             | tcore_setid_binaries_idmapped_mounts_in_userns_separate_userns
> >             | tcore_sticky_bit_unlink_idmapped_mounts
> >             | tcore_sticky_bit_unlink_idmapped_mounts_in_userns
> >             | tcore_sticky_bit_rename_idmapped_mounts
> >             | tcore_sticky_bit_rename_idmapped_mounts_in_userns
> > ------------|-------------------------------------------------------
> > chmod       | protected_symlinks
> >             | tcore_protected_symlinks_idmapped_mounts_in_userns
> > ------------|-------------------------------------------------------
> > io_uring    | io_uring io_uring_userns tcore_io_uring_idmapped_userns
> >             | tcore_io_uring_idmapped_unmapped
> >             | tcore_io_uring_idmapped_unmapped_userns
> > ------------|-------------------------------------------------------
> > mknod       | tcore_expected_uid_gid_idmapped_mounts
> >
> > Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> > Reviewed-by: Friendy Su <friendy.su@sony.com>
> > ---
> >  tests/generic/633 | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tests/generic/633 b/tests/generic/633
> > index f58dbbf5..e19a2043 100755
> > --- a/tests/generic/633
> > +++ b/tests/generic/633
> > @@ -13,6 +13,12 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
> >  . ./common/filter
> >
> >  _require_idmapped_mounts
> 
> Please note that the requirement above is wrong:
> 
> https://lore.kernel.org/fstests/20250526175437.1528310-1-amir73il@gmail.com/
> 
> > +_require_hardlinks
> > +_require_symlinks
> > +_require_chown
> > +_require_chmod
> > +_require_io_uring
> > +_require_mknod
> 
> I wonder if it makes more sense to have a collective check for all (or
> most) of the above,
> e.g. _require_vfstest, which is different than _require_idmapped_mounts,
> so that we do not have to add all of these for tests running
> other vfstests subtests in the future.

Yeah, and some _require_ looks optional, e.g. _require_io_uring, why is it a
necessary requirement, we even run xfstests with io_uring. If so, we don't do
vfstest if io_uring isn't supported?

Although we can add as many as possible _require_* checks to a test case, but
more _require_* take more time to run. So I think we'd better to add "missed"
_require_* for specific test failure on someone fs, not only "I reviewed the
code, so I feel all of these are needed"

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 

