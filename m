Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E24A29
	for <fstests@vger.kernel.org>; Mon, 14 Apr 2025 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610348; cv=none; b=bfwhrysvHut8gmaMJGYJsj95O6dyHFfR2md4KS9RFoyOlq7p/AGdfZrDsirfX6b1tgLJpmiMEI0CXPT3tDYYS+zy5cExaLwr+5P1sCIN6hG9O/mCfL9KI8tHQSpAQmBn61WKE6r/FXWOAbkKiavlBr95pcFgPoaXTPVpy/PWd+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610348; c=relaxed/simple;
	bh=O/+P6UHdiiiLJ9S0915lY6FrTgAk37edEMTWj3ysGcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl6oSaOPbUVoCYZTkiEZu9NI2oOp7lXEixvfor5AcNRroFfSXjhat99NXLZGRAc0yWtAyLcJKpWPE7MwScHySvZBhOsyHoolbvwJ9wEfsD564vHbaGB+vL8NUluxs88qg8+uSNBqBxB2GOubIyjCF8S42yE8rR4av5k6GpPIlaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiiaGqi8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiiaGqi8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744610345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3vpZzO1IKjjrI7weLLsfR0ytu7kb+hwfvLc+24LbL4=;
	b=GiiaGqi8rU2LOJHDidbVLzDej96k+LgR3QXbNtQYa79QJUoJ7ngMIjX6OaZdeR7yheVGXU
	jBXxVfCI/KpQ+9HwE97Wr8rNqGxjIJtoyP6H+prMAOrNfOOyVuZQvkUOqw5adK1LAkW6T3
	Fes+MaT4qyzfcPIPrUHxZnwOVOg4xZ0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-eS7N_MBFMA-6Ju9AelXZoA-1; Mon, 14 Apr 2025 01:59:03 -0400
X-MC-Unique: eS7N_MBFMA-6Ju9AelXZoA-1
X-Mimecast-MFC-AGG-ID: eS7N_MBFMA-6Ju9AelXZoA_1744610343
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-af59547f55bso2283665a12.0
        for <fstests@vger.kernel.org>; Sun, 13 Apr 2025 22:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610342; x=1745215142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3vpZzO1IKjjrI7weLLsfR0ytu7kb+hwfvLc+24LbL4=;
        b=hUjVXncp2Fx07sHGE6lsAQzwtAT6kRiCHI59ELACPjGJamUB9x/HDbvvqNVOlzizdE
         duq8Fz0LdANemnYDi7TrG8xmKgT4bFovu9U2MWBvw0skAFV2+J3W5i+yaaZs0dzhhIyH
         r9HUBnsSQr8T3MAfV8lHmixJlTbhs4pHcsdBt/h95BdfkxC6OG9z9Fu2DhE15kJKkUvR
         MyNRXhnnh/17xMiNNk8aFeqQrk3N94H35b4+GHLrPFZmADBbWmx1DW3Og97hbLpymUVE
         /pqvoh5Tr+CZkpKVqbOEZuvqCo5F0ZZJJvc/DODGAsy0y51VXZdYXHaQzdhBczLaM/tr
         YuGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8JMHozkKG+Et3eq6zKXslN+6Y/G9lqumsQZYSO71yNpe1hsGD8KCojt2k0fLWeU54p3nYGkSs@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGxcoY114Pwv1kowStJgfEBoNcL7VJQfImZnda5HUdsmbQdVF
	jnVuo2zEiqXRagey6/QdLH8N6kUzK3YHdvdj393as0H1OBOhCNo2DQVCLTXirRLmAm0RvoaddCl
	7msPKUfR8tgo4O5SyzEB6EKVD4WyWdtpiESX1Ew6XfbiHO/gWiWZ6v5M=
X-Gm-Gg: ASbGncvhxx/nYtSXw9iDNrzPmmUkRI/DLhUaOPvH0Qg79bYb5QX9cdcecMoSOaCKwKp
	LYXFjZlFzAIndNnSa5RyWLRiDb3YBMRfAr2poROAQNILEll9FfdY1ed5/e8P9JhAfiV5eWF3/zb
	aCIj2wFkoNzZG8qnT1VJIoryUzfdzvQPRzsGy9scbOqDU7Wj8f3LRsbmcrva+Esde6gxFrLx1Pp
	cqDNw9kWMpNznjXkF77YJTYP7MUB5FwDT7iZSwQcVN0Pam0Y7qOFe9D2E6PIthuIUvNwCI0JV2I
	4Ae25jwUqiozHtp9DCaLqORVpHHih7KFVPQ2CFCc5YKY9YFwTlGU
X-Received: by 2002:a17:902:e788:b0:223:4c09:20b8 with SMTP id d9443c01a7336-22bea4f0043mr152503255ad.37.1744610342274;
        Sun, 13 Apr 2025 22:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4WFg2dhdeBMmaxTN/dxrj8j3X87o6sJSv0cmCghse4HvomrId2kYh5X2iJA+pPvRVH4s6OQ==
X-Received: by 2002:a17:902:e788:b0:223:4c09:20b8 with SMTP id d9443c01a7336-22bea4f0043mr152502985ad.37.1744610341633;
        Sun, 13 Apr 2025 22:59:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8ae95sm91588485ad.61.2025.04.13.22.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 22:59:01 -0700 (PDT)
Date: Mon, 14 Apr 2025 13:58:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] README: add supported fs list
Message-ID: <20250414055857.w2zvapp3mjintgar@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250328164609.188062-1-zlang@kernel.org>
 <u2pigq4tq5aj5qvjrf3idna7hfdl6b4ciko5jvorkyorg25dck@4ti6fjx55hda>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u2pigq4tq5aj5qvjrf3idna7hfdl6b4ciko5jvorkyorg25dck@4ti6fjx55hda>

On Sun, Apr 13, 2025 at 05:56:08PM -0400, Kent Overstreet wrote:
> On Sat, Mar 29, 2025 at 12:46:09AM +0800, Zorro Lang wrote:
> > To clarify the supported filesystems by fstests, add a fs list to
> > README file.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > Acked-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> > 
> > The v1 patch and review points:
> > https://lore.kernel.org/fstests/20250227200514.4085734-1-zlang@kernel.org/
> > 
> > V2 did below things:
> > 1) Fix some wrong english sentences
> > 2) Explain the meaning of "+" and "-".
> > 3) Add a link to btrfs comment.
> > 4) Split ext2/3/4 to 3 lines.
> > 5) Reorder the fs list by "Level".
> > 
> > Thanks,
> > Zorro
> > 
> >  README | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> > 
> > diff --git a/README b/README
> > index 024d39531..5ceaa0c1e 100644
> > --- a/README
> > +++ b/README
> > @@ -1,3 +1,93 @@
> > +_______________________
> > +SUPPORTED FS LIST
> > +_______________________
> > +
> > +History
> > +-------
> > +
> > +Firstly, xfstests is the old name of this project, due to it was originally
> > +developed for testing the XFS file system on the SGI's Irix operating system.
> > +When xfs was ported to Linux, so was xfstests, now it only supports Linux.
> > +
> > +As xfstests has many test cases that can be run on some other filesystems,
> > +we call them "generic" (and "shared", but it has been removed) cases, you
> > +can find them in tests/generic/ directory. Then more and more filesystems
> > +started to use xfstests, and contribute patches. Today xfstests is used
> > +as a file system regression test suite for lots of Linux's major file systems.
> > +So it's not "xfs"tests only, we tend to call it "fstests" now.
> > +
> > +Supported fs
> > +------------
> > +
> > +Firstly, there's not hard restriction about which filesystem can use fstests.
> > +Any filesystem can give fstests a try.
> > +
> > +Although fstests supports many filesystems, they have different support level
> > +by fstests. So mark it with 4 levels as below:
> > +
> > +L1: Fstests can be run on the specified fs basically.
> > +L2: Rare support from the specified fs list to fix some generic test failures.
> > +L3: Normal support from the specified fs list, has some own cases.
> > +L4: Active support from the fs list, has lots of own cases.
> > +
> > +("+" means a slightly higher than the current level, but not reach to the next.
> > +"-" is opposite, means a little bit lower than the current level.)
> > +
> > ++------------+-------+---------------------------------------------------------+
> > +| Filesystem | Level |                       Comment                           |
> > ++------------+-------+---------------------------------------------------------+
> > +| XFS        |  L4+  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Btrfs      |  L4   | https://btrfs.readthedocs.io/en/latest/dev/Development-\|
> > +|            |       | notes.html#fstests-setup                                |
> > ++------------+-------+---------------------------------------------------------+
> > +| Ext4       |  L4   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Ext2       |  L3   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Ext3       |  L3   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| overlay    |  L3   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| f2fs       |  L3-  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| tmpfs      |  L3-  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| NFS        |  L2+  | https://linux-nfs.org/wiki/index.php/Xfstests           |
> > ++------------+-------+---------------------------------------------------------+
> > +| Ceph       |  L2   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| CIFS       |  L2-  | https://wiki.samba.org/index.php/Xfstesting-cifs        |
> > ++------------+-------+---------------------------------------------------------+
> > +| ocfs2      |  L2-  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Bcachefs   |  L1+  | N/A                                                     |
> 
> I heavily use xfstests and look at the test results every day - I
> believe that would indicate L3.

Glad to receive the response from bcachefs :) L3 means there're enough fs specific
test cases in tests/$FSTYP besides generic cases, e.g. tests/overlay, or f2fs (although
it only has a few currently, but it's increasing).

> 
> bcachefs specific tests are not generally in fstests beacuse there's
> lots of things that ktest can do that fstests can't, and I find it a bit
> more modern (i.e. tests that names, not numbers)

ktest? linux/tools/testing/ktest/ ? I'm glad to learn about more test suites,
I run fstests and LTP and some others too, fstests can't cover everything :)
Hmm... about the names... fstests supports to append a name to the ID number,
but the developers (looks like) prefer using number only all the time, then
it become a "tradition" now.

> 
> Not all tests are passing (and won't be for awhile), but the remaining
> stuff is non critical (i.e. fsync() error behaviour when the filesystem
> has been shutdown, or certain device removal tests where the behaviour
> could probably use some discussion.
> 
> But if you find e.g. a configuration that produces a generic/388 pop,
> that would go to the top of the pile.
> 
> (I do have a few patches to the tests for bcachefs in my tree that I
> really ought to get upstream).

Sure, warm welcome your patches. And don't worry, you can send patch to
update the level part anytime when you think fstests supports becachefs
more :)

Thanks,
Zorro

> 

