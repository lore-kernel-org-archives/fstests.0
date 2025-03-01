Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1C1CEAC3
	for <fstests@vger.kernel.org>; Sat,  1 Mar 2025 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740828668; cv=none; b=XCYmomA7K0KtBPgriLkFcfVVmZ/9eBBPf8dg+fdF3PjfyQUevQdfR5gDX/l2gCfjafniwOfPkNyIPRUB8YJvTpuo75acT36vi07fX4Z3B6Iwv41c+xQ9yTf7x9VNdVJByggGVWtBiyRH6xxU0/kjwGfntVPB6Fir62wIIrvpYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740828668; c=relaxed/simple;
	bh=jJWJ+7dch+KIgO6/WsfgVy4OrZp7IE1jdT0gR7F6XxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtOlywLFOXF+gINgOCYc4ZAFpg7QTR36kIpAnOce4cs9Q6Y5T19j5fh6TSJa2WONTTXsvpn82xv96QDH4NONT/ScpIoXF9nJXHon/+8lLsWYF0bh7Eo7v3dhTuVz8labmOu80+LpGRNzlzNnIJwG/GIXmNuVXQ5EvF8lzWxSudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZwY1Fqt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZwY1Fqt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740828665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CHupQ4vkoeTHA07biLIg1Y4LGkVkPD7KqDtA0lVW4Lg=;
	b=WZwY1FqtQGJ5N769t9Yb4Z8o6IG786tUwcX55CSS9WOnUsycBeiJmxU2R95dbTTcOtPKYH
	ty144qEbr3/CH7LcSusbI1lKFWihWcQTrnt1J9iBVI0GgYkH+QQJyDILbB6FbX1oalOpyR
	qGapskRwrQfJSQZUmnfBTNdIzgSY8Ys=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-_Rqy5ZopP6uFSBPP0iy1tA-1; Sat, 01 Mar 2025 06:30:54 -0500
X-MC-Unique: _Rqy5ZopP6uFSBPP0iy1tA-1
X-Mimecast-MFC-AGG-ID: _Rqy5ZopP6uFSBPP0iy1tA_1740828653
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2235667c974so74240385ad.0
        for <fstests@vger.kernel.org>; Sat, 01 Mar 2025 03:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740828653; x=1741433453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHupQ4vkoeTHA07biLIg1Y4LGkVkPD7KqDtA0lVW4Lg=;
        b=vaV5ERdPm6/WM0ogL2NOBnwDSH9S/kaWT3lj2+E6XmEHUNiKfYWHCl6zg2kXtUEN2C
         9/XpMOlkJ8i/VhGn5Z/ATJ1Dih+b42U937bDJNWIdT/s0nyybx98xXQqNszcfL4VNGb2
         m11L0OGNYNpn37YOJ7nrHMkA98TxYq60LeEIDm7vA3IqJyUVGCZ73/qH0WguXr1hTiOC
         cmlM3QcI6EkgPmzf4lUbB+MAcSXUdgmNg5Uurlay7CDeRVQdhtYo9PwkcHHLyqWQEZU4
         z7lwxfKEVkc0aHdi1b33c4UtdxvTVY728T5yga7iU0hXhrKx+82Iu4RV9PE/p/vm8nFR
         k46A==
X-Forwarded-Encrypted: i=1; AJvYcCWUHuKcYoCOdvFXKaDwPb7wA2zeUlXkvtsIPz5Vr9XAAIgnh20FdYRLKHi1k3UiNXKohXYGT+TH@vger.kernel.org
X-Gm-Message-State: AOJu0YzT9XTbvWzxhj6+A4I6FVW5vAxfvTmp4AoIBeWyIod+2A1uK99P
	KojGMk02c292MbjQTsk+XEsVBSPDTD1xl78mc8jkwd0zrVA5UI52KKmh0Xp4FwPiI5/4zY4/pDU
	ApRMi3RoSCLWLnhx10AgHikHrbOoLEtFlHkNoqk00qiJ9Y+fnUWVVjQ0=
X-Gm-Gg: ASbGncvaI2jNV3oN7gwbx9UnMDADh4REblgAUf7EZzPh9CbrceiPVy8vHcUUyowwYFQ
	X7JLKJG2F1RuVQwXYGmBRiYXKtLImrWf74n3tNoeOwEsol3blMvLbVzwLIdB/t+nca3txcs1L17
	8izFITMqcUNbop5y5zEomKt1129IdLFF95yS7zlJ94bo6PZydaWMX+zKcgsQWIGTPbIfr+WRrKw
	G6r1yTm9jCvif89SWcL71J+suW5HRb0hyo+p5c147bjQyAQadziocuM1l4iK9jJCYzEhD5jnf+3
	IvDmd43bzJWQaVE8IQU2BxcyAAOhavHDijbTHYtX/IhpwpkRp2+5GdgQ
X-Received: by 2002:a17:902:f60a:b0:220:f1a1:b6e1 with SMTP id d9443c01a7336-22368fc03edmr108596395ad.19.1740828653028;
        Sat, 01 Mar 2025 03:30:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvDffNdjqOjGxTnZzt1+ZsHBzc6rlft0mYSTe5xrz9OhpsdW3yREGtKnvgX6HwBT4K9jlopA==
X-Received: by 2002:a17:902:f60a:b0:220:f1a1:b6e1 with SMTP id d9443c01a7336-22368fc03edmr108596025ad.19.1740828652478;
        Sat, 01 Mar 2025 03:30:52 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2732sm47552525ad.23.2025.03.01.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 03:30:52 -0800 (PST)
Date: Sat, 1 Mar 2025 19:30:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] README: add supported fs list
Message-ID: <20250301113047.4pwg6mdaqh46ntym@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250227200514.4085734-1-zlang@kernel.org>
 <20250228135550.GH5777@suse.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228135550.GH5777@suse.cz>

On Fri, Feb 28, 2025 at 02:55:50PM +0100, David Sterba wrote:
> On Fri, Feb 28, 2025 at 04:05:14AM +0800, Zorro Lang wrote:
> > To clarify the supported filesystems by fstests, add a fs list to
> > README file.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> > 
> > Hi,
> > 
> > David Sterba suggests to have a supported fs list in fstests:
> > 
> > https://lore.kernel.org/fstests/20250227073535.7gt7mj5gunp67axr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#m742e4f1f6668d39c1a48450e7176a366e0a2f6f9
> > 
> > I think that's a good suggestion, so I send this patch now. But tell the truth,
> > it's hard to find all filesystems which are supported by fstests. Especially
> > some filesystems might use fstests, but never be metioned in fstests code.
> > So please review this patch or send another patch to tell fstests@ list, if
> > you know any other filesystem is suppported.
> 
> The idea is to make the list best-effort, we don't know which of the L1
> and L2 are tested. It would be interesting to try them to see the actual
> level of support. I kind of doubt that anybody has run e.g. pvfs2 recently.

Hi David,

Thanks for your reviewing :)

I never tried pvfs2 either. The "level" won't be changeless. That depends on how
many test cases are there for the specific fs. L1 means I never saw more patches
after one patch named "add support to $FSTYP" to change common/rc a bit. L2
means I saw a few more fixes after that signle patch. Anyway, if someone is
still testing on someone FSTYP, please feel free to share your experience and
change the level.

> 
> 
> > And if anyone has review point about the support "level" and "comment" part,
> > please feel free to tell me :)
> > 
> > Thanks,
> > Zorro
> > 
> >  README | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> > 
> > diff --git a/README b/README
> > index 024d39531..055935917 100644
> > --- a/README
> > +++ b/README
> > @@ -1,3 +1,85 @@
> > +_______________________
> > +SUPPORTED FS LIST
> > +_______________________
> > +
> > +History
> > +-------
> > +
> > +Firstly, xfstests is the old name of this project, due to it was originally
> > +developed for testing the XFS file system on the SGI's Irix operating system.
> > +With xfs was ported to Linux, so was xfstests, now it only supports Linux.
> > +
> > +As xfstests has some test cases are good to run on some other filesystems,
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
> 
> This could list what are the assumptions of a generic filesystem. For
> example the mkfs.$FSTYP and fsck.$FSTYP should exist as the generic
> fallback applies (other filesystems have the exceptions that skip eg.
> fsck if it's known not to exist).

Is there a place to know all mkfs.$FSTYP? The "man 8 mkfs" doesn't give much
information.

I'd not like to list the fs which isn't metioned in xfstests and never tried by
others. But I'm very glad to add more later :)

I can change above sentence as below:

"Any filesystem can give fstests a try, especially the fs is supported by
mkfs -t $FSTYP, mount -t $FSTYP and fsck -t $FSTYP."


> 
> > +Although fstests supports many filesystems, they have different support level
> > +by fstests. So mark it with 4 levels as below:
> > +
> > +L1: Fstests can be run on the specified fs basically.
> > +L2: Rare support from the specified fs list to fix some generic test failures.
> > +L3: Normal support from the specified fs list, has some own cases.
> > +L4: Active support from the fs list, has lots of own cases.
> > +
> > ++------------+-------+---------------------------------------------------------+
> > +| Filesystem | Level |                       Comment                           |
> > ++------------+-------+---------------------------------------------------------+
> > +| AFS        |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Bcachefs   |  L1+  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Btrfs      |  L4   | N/A                                                     |
> 
> https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#fstests-setup
> 
> some additional information about required packages, kernel configs and
> devices. This could be in fstests/README too.

Sure, I'll add it.

> 
> > ++------------+-------+---------------------------------------------------------+
> > +| Ceph       |  L2   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| CIFS       |  L2-  | https://wiki.samba.org/index.php/Xfstesting-cifs        |
> > ++------------+-------+---------------------------------------------------------+
> > +| Ext2/3/4   |  L3+  | N/A                                                     |
> 
> I'd suggest to split ext4 from that and give it L4, not sure if ext2 is
> still being tested maybe it's worth L3. The standalone Ext3 module does
> not exist and is covered by ext4, so it probably works with fstests but
> is interesting maybe only for historical reasons.

Actually I hesitated about the level of ext4. I gave L4 to btrfs due to it has 330+
specific test cases in tests/btrfs, besides generic tests. But ExtN has 70 (besides
generic), so I set L3+. Anyway, L4 or L3+ are both good to me. If you recommend L4,
I can change that.

> 
> > ++------------+-------+---------------------------------------------------------+
> > +| Exfat      |  L1+  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| f2fs       |  L3-  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| FUSE       |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| GFS2       |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Glusterfs  |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| JFS        |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| NFS        |  L2+  | https://linux-nfs.org/wiki/index.php/Xfstests           |
> > ++------------+-------+---------------------------------------------------------+
> > +| ocfs2      |  L2-  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| overlay    |  L3   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| pvfs2      |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Reiser4    |  L1   | Reiserfs has been removed, only left reiser4            |
> > ++------------+-------+---------------------------------------------------------+
> > +| tmpfs      |  L3-  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| ubifs      |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| udf        |  L1+  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Virtiofs   |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| XFS        |  L4+  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| 9p         |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> 
> The table works as the way to present it but with so few links/comments
> writing it as a simple list could give a better idea what filesystems
> are in each category. Sorted alphabetically, like:
> 
> L4: Btrfs, Ext4, XFS
> L3: ...
> etc

I wrote many "N/A" due to I don't know what does the specific fs list want to
comment. Likes you provide a link for btrfs, I don't know if other fs would
like to change their part. So I tried to leave the "whiteboard" to them, hope
each fs list can share how do they use fstests, that might be helpful for
other users would like to join.

If you think the "level" is more useful, I can list them in "level" order.
Currently I list them in name's alphabetical order.

Thanks,
Zorro

> 

