Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0EDF5C
	for <fstests@vger.kernel.org>; Fri,  6 Jun 2025 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749172003; cv=none; b=Yf4ob+ZpgBk2i91mRz647cwLFBs3Cl8qlZHMjnUlOcfb2hipOyxFSrBvPtO48T5ELkL4mb70/n08TH6ZV7cRipuC8WA4cOp9ZQVjBiInJHT0CDxn1AfjT8dkoR4K0PvDpq33fBTOubHlIWxUjq10vmVw+aGdYNbnlw01plSAvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749172003; c=relaxed/simple;
	bh=WHiRYQVzpF/lN2vRCzWbGZycny0BE1b7Qf7hG/Pz0lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFltbG4PFPA2qocrif60YvOS/cAWcv19D4e6Ts2lilmqiLybwf0oBrZDIo3X93HXRyzHIHK8jFk8S5dfzjSZxSARS5JgehJ8veWJgqbH2/BYfuPqiIo4lzFRFy+dmi2DUMhdN2T5vNkRKKB5qi1cM1r2A3a2EUlqRfRp+3ZThz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tt9mH5Ka; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tt9mH5Ka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749172000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMqwuMMmnYZ789XHUBu0zSaDdKty5JzMfz62cv6P90Q=;
	b=Tt9mH5Ka6CRAh61uMgwEL0XB/MXxSOy20xmAUYBDDfkvJ5LU7o+5soOz88aIzlLKOWJkmV
	PWMSeuJoHH0lNejOF57qoJVXTxj78IOawfjTeRvspAzBSOWdNDGIBTcByNjzZd8NaE43AJ
	hjkB03T1j4CWYD/DXdw72ZZ/NZgjxLY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-KDe1saPiP8-mElzNNHN6mQ-1; Thu, 05 Jun 2025 21:06:39 -0400
X-MC-Unique: KDe1saPiP8-mElzNNHN6mQ-1
X-Mimecast-MFC-AGG-ID: KDe1saPiP8-mElzNNHN6mQ_1749171999
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fac216872cso29226106d6.2
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 18:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749171999; x=1749776799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMqwuMMmnYZ789XHUBu0zSaDdKty5JzMfz62cv6P90Q=;
        b=XuVrl6ybFj6wri4WPDw4ZPBsr4/rPT1YwPTBkuGkgFJvkVNQgA6o0Mr4FON8m1Sa31
         cLLdj/k0UUNGILFg9g7eufh4pzmvGhtbS5Guls2gmCJZ3wwxMsDRKXSA/9nQKw9Z88WF
         4nUi+q+VvNg3fq5Dk39xVqVh8WcfCA2cJeHcDinh3tPq3/3kPEKPnYI9MH3FaVTMfBiH
         yM6EyzVDASF+Qq/6KKmcQjCwab397zlUrHpo27d2GDVS3+7jjSeSKJiV26RdEOujIf0k
         I9EnsW6HWerr/oohp4Kqcj7mVPdEJq69QRf8AsOjbvfaybX/qEFyyZP9HJZENiqkx4py
         3MvA==
X-Forwarded-Encrypted: i=1; AJvYcCXk1OYRG2CbCBXtB3TogrE3Th0SoKMSjM3GGlOVIyR+mSKzD1UfV02RJavVw1Gffvh1Y7fsWFBf@vger.kernel.org
X-Gm-Message-State: AOJu0YzLnzP55jT5xbYO7tfJ32xE7DgZMPKoznw02HNQKr3ssa14QP7p
	96sy4B3TqMop6KLngNzwN1cXPHb1JprB0mW4NCMQICASnt2cz/uoTRIdDdtny+i1V/684UHmeWa
	KXULJosfl9HMGj5qsW9BZ2g7sAoykhjE7xUlPfd8ZWB5dcsx5Zfema78x0IKQVmEaI6w=
X-Gm-Gg: ASbGncsvh4d92e6ceZ8BnX1Z9nA4UiY94nzviRdBzy5OCAgj+PiiRJTY98THqikQmO4
	RkmRXANV3H6fD+5y3SC7BIEbkmW3bKEH8+CGiOKZw004XQdtvkT1Xkdu94hIR1/Ae0YTWuwrWQX
	CB7gFwEHuiLFOqcObDx22cR+t1IB3dqpa1yU5s++6WkAexOOSSEfcQwLyNXCKln8oxMIGctcBUN
	4vAEdryeTFjb9kl3n+99EmijCLElFiiQvh3Oza/OpKEIr8pfLnRuhRNBN6VmQiO9wjEzgWkeXBa
	ZD+cgGGPut6gkWwdcTyYuNoEE59uvCb1rIv177Vw8cuKrkKDVxi7
X-Received: by 2002:a0c:f94c:0:b0:6fa:c67f:5e66 with SMTP id 6a1803df08f44-6fb08fe4ab1mr19337756d6.39.1749171998694;
        Thu, 05 Jun 2025 18:06:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUhlY4zDEpsR++g5fzNRPqdPHGUK1mUpVUReGtVIuRYAak2rp1JJRU3qVIYCO4Dn59JG1SPg==
X-Received: by 2002:a05:6a21:999c:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-21ee68c8addmr1690400637.20.1749171987254;
        Thu, 05 Jun 2025 18:06:27 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0eaa1csm260243b3a.162.2025.06.05.18.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 18:06:26 -0700 (PDT)
Date: Fri, 6 Jun 2025 09:06:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/741: make cleanup to handle test
 failure properly
Message-ID: <20250606010622.imrfexkypzq5zpm6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250604235524.26356-1-wqu@suse.com>
 <20250605171047.vl3u6j7yojbw6pfe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <dbf243a2-ac0e-437c-a308-9832f89ca274@gmx.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbf243a2-ac0e-437c-a308-9832f89ca274@gmx.com>

On Fri, Jun 06, 2025 at 07:39:56AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/6 02:40, Zorro Lang 写道:
> > On Thu, Jun 05, 2025 at 09:25:24AM +0930, Qu Wenruo wrote:
> > > [BUG]
> > > When I was tinkering the bdev open holder parameter, it caused a bug
> > > that it no longer rejects mounting the underlying device of a
> > > device-mapper.
> > > 
> > > And the test case properly detects the regression:
> > > 
> > > generic/741 1s ... umount: /mnt/test: target is busy.
> > > _check_btrfs_filesystem: filesystem on /dev/mapper/test-test is inconsistent
> > > (see /home/adam/xfstests/results//generic/741.full for details)
> > > Trying to repair broken TEST_DEV file system
> > > _check_btrfs_filesystem: filesystem on /dev/mapper/test-scratch1 is inconsistent
> > > (see /home/adam/xfstests/results//generic/741.full for details)
> > > - output mismatch (see /home/adam/xfstests/results//generic/741.out.bad)
> > >      --- tests/generic/741.out	2024-04-06 08:10:44.773333344 +1030
> > >      +++ /home/adam/xfstests/results//generic/741.out.bad	2025-06-05 09:18:03.675049206 +0930
> > >      @@ -1,3 +1,2 @@
> > >       QA output created by 741
> > >      -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
> > >      -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
> > >      +rm: cannot remove '/mnt/test/extra_mnt': Device or resource busy
> > >      ...
> > >      (Run 'diff -u /home/adam/xfstests/tests/generic/741.out /home/adam/xfstests/results//generic/741.out.bad'  to see the entire diff)
> > > 
> > > The problem is, all later test will fail, because the $SCRATCH_DEV is
> > > still mounted at $extra_mnt:
> > > 
> > >   TEST_DEV=/dev/mapper/test-test is mounted but not on TEST_DIR=/mnt/test - aborting
> > >   Already mounted result:
> > >   /dev/mapper/test-test /mnt/test /dev/mapper/test-test /mnt/test
> > > 
> > > [CAUSE]
> > > The test case itself is doing two expected-to-fail mounts, but the
> > > cleanup function is only doing unmount once, if the mount succeeded
> > > unexpectedly, the $SCRATCH_DEV will be mounted at $extra_mnt forever.
> > > 
> > > [ENHANCEMENT]
> > > To avoid screwing up later test cases, do the $extra_mnt cleanup twice
> > > to handle the unexpected mount success.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   tests/generic/741 | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/tests/generic/741 b/tests/generic/741
> > > index cac7045e..c15dc434 100755
> > > --- a/tests/generic/741
> > > +++ b/tests/generic/741
> > > @@ -13,6 +13,10 @@ _begin_fstest auto quick volume tempfsid
> > >   # Override the default cleanup function.
> > >   _cleanup()
> > >   {
> > > +	# If by somehow the fs mounted the underlying device (twice), we have
> > > +	# to  make sure $extra_mnt is not mounted, or TEST_DEV can not be
> > > +	# unmounted for fsck.
> > > +	_unmount $extra_mnt &> /dev/null
> > 
> > Hmm... I'm not sure a "double" (even treble) umount is good solution for
> > temporary "Device or resource busy" after umount. Many other cases might
> > hit this problem sometimes.
> > Maybe we can have a helper to do a certain umount which make sure the fs
> > is truely umounted before returning :)
> 
> This is not about the umount after EBUSY.
> 
> The problem is, the test case itself is expecting two mounts to fail.
> But if the mount succeeded, it will mount twice and need to be unmounted
> twice.
> 
> It's to make the cleanup to match the test case's worst scenario.

Oh, sorry I didn't get your point. If so, how about _fail the case directly if
the first mount (which should be failed) passed, e.g.

  diff --git a/tests/generic/741 b/tests/generic/741
  index cac7045eb..5538b3a1b 100755
  --- a/tests/generic/741
  +++ b/tests/generic/741
  @@ -44,6 +44,9 @@ mkdir -p $extra_mnt
   # Filters alter the return code of the mount.
   _mount $SCRATCH_DEV $extra_mnt 2>&1 | \
                          _filter_testdir_and_scratch | _filter_error_mount
  +if [ ${PIPESTATUS[0]} -eq 0 ];then
  +       _fail "Unexpected mount pass"
  +fi

Anyway, I can't say which way is better, both are good to me, depends on your
choice :)

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > 
> > Thanks,
> > Zorro
> > 
> > >   	_unmount $extra_mnt &> /dev/null
> > >   	rm -rf $extra_mnt
> > >   	_unmount_flakey
> > > -- 
> > > 2.49.0
> > > 
> > > 
> > 
> > 
> 

