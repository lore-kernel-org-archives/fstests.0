Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A71A287E
	for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397116; cv=none; b=CLVQqiD6MtNejcdOBCLaz9gjeM9Cw8aFfaw4akyZZv0UW6QS6WKCI7N34X86p+8geaUFqdTd7SBrpR5TlclhxJM6q7pFt3cjBs2MqdCBa21GzBZC5AN2zoC6ar5hqKs9Od/HDE/CB6cT+1Fg5PlKiG+hi6JZypmnF0v2T+WugpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397116; c=relaxed/simple;
	bh=vtX+5SvSzsUwfd6k6Z4ufYXzC8kZgwrldiWr5BVioHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQ6heVUeP24DpLWvtsHi6lHxB3sK82qJ6kz5Nbjnkp6VeNjwTVYU4GDjrh6v0EzxBup0G1TQhF0KSBxrnYmPUrVwxMrbd6Ioh/GRpddcmOtEy8Gf2/kOcLH1PYO6Ry2AibULAQBmgqDQipyHaEtz5nAJhbaW9GzMvALSxB/aGmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U74l18Rs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U74l18Rs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742397113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i4KSVKPtaTj+sOBsrbtnf/Pl8QpcLZWVsioZqzoadiM=;
	b=U74l18RsA26SbDd4vernlK+Ur84JueKRq3aBYc0NKES0Mju6QpVJmEw+FNYfrWr8ALB9zT
	TjtKp64wZ3R8PC74EhcUpT0/abdKZnAW/WEWlWF+hbCI2Gl56BsFeSKNXFw7yU9ljeCFKT
	4J6lz297w/ODHALhoNMOrvkWQO4Ymfk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-NVDcm8hMNDK3XY4jXa_dBA-1; Wed, 19 Mar 2025 11:11:51 -0400
X-MC-Unique: NVDcm8hMNDK3XY4jXa_dBA-1
X-Mimecast-MFC-AGG-ID: NVDcm8hMNDK3XY4jXa_dBA_1742397110
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff82dd6de0so6288969a91.0
        for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 08:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742397110; x=1743001910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4KSVKPtaTj+sOBsrbtnf/Pl8QpcLZWVsioZqzoadiM=;
        b=FrXYR1KE927vU5Zj+RvSZxJV8LeZgzb12fQAtFoOjQVxBwDNBOF5KdhNAiuBUQpv0S
         JR+nCqhFTBgbyqb4CKu3AIQ3RTgC9ZWkOWcdGoHceMCWMBo2qmA06s6EpkLwmmzm0jGK
         B5n2LEW2SWTwZREdoEQ7p7tkbkG+WITMC1FLd7i8rDqKWsHLgkDgRYIZworOvzJ8CjB6
         5y13Ps07W59Za472pYce1pSqxmNl+uH9IWiezl9gZBBfYZjU6hRb/LMxUs97R7r5Fdx9
         YesYlzYuTK9D2KdzqM03RWKxF+awtkwC2VzHaQD9sqpEJWFlAW0zd9wPlKWGjDg2lari
         GRdg==
X-Forwarded-Encrypted: i=1; AJvYcCVU0hM8eOj+eTvxmc+ZmHOV1FAUpxeRiSXKcggrDAB9hiDpmUh4niZD5oi4Z7xcatnbM4kONd2D@vger.kernel.org
X-Gm-Message-State: AOJu0YxbL160d51XFLk/rd04BvEJXWf3fXowXhW/TBW/DURKO3scaP7M
	l9pRGIxZRcRpt1bj6wNqCheg7QznPOLuIflE1xPwWxG2Unkd1Bsg6ReE1E5IMSUD3R8/UKtBaYn
	DnVx3f907I3S873ZxfxRWtrE0WvVyo53vI2SZY+BUC4uBk+JaYn8tZq/H5kOwUJxLFA==
X-Gm-Gg: ASbGnctWKEWxJBxo8NJnAXaH8hoBKapU5IUxn9cuX9ZukRLKP+Kp6kEYB0rRl7uht0W
	TfjAJkJKy6dwry0Bdgrv6s1hTZfMb8UvyMiPo5IhTOZE4OOJx3azQoIuXSvCI0+wigAKomsF0B5
	3zG3RvXEaU7ZHJ5kan5n6ByxZQeXOqn0dUlhcLtVJz7FiC+hOYot20ep33sJHvUKQIFi1x300xj
	rAQ4Poenj4lgnGVIJh0RPjMNDkqqMrl3RAQHgKAHyPnRi3Zrfxzfyu+hJWIT/x6DCX9we4JYeBU
	qCdxF1aepCeoXvHorAlEZgoen7WlzqgI4+43cxtrNFiYBFAdkfb+dkKM
X-Received: by 2002:a17:90a:3f17:b0:301:cba1:7ada with SMTP id 98e67ed59e1d1-301cba17e75mr1160113a91.1.1742397109935;
        Wed, 19 Mar 2025 08:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwhIL3oPfttiDLIurR3jvWCi/rSpOWaQyto7vH5y8Va2SeirFrwH1MxBHQ7Bj2PCJ3El0auQ==
X-Received: by 2002:a17:90a:3f17:b0:301:cba1:7ada with SMTP id 98e67ed59e1d1-301cba17e75mr1160094a91.1.1742397109622;
        Wed, 19 Mar 2025 08:11:49 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf575936sm1705819a91.4.2025.03.19.08.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:11:49 -0700 (PDT)
Date: Wed, 19 Mar 2025 23:11:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Theodore Ts'o <tytso@mit.edu>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: generic/699 fails on ext4 due to using ext4 mount options w/
 overlayfs
Message-ID: <20250319151144.3r27tjgenbzty5tr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c46d8caf-053a-4af1-b562-7ca7203cb926@sandeen.net>
 <20250318235116.GE787758@mit.edu>
 <ffed04f3-5743-4a92-9b2c-20887c04a4cf@sandeen.net>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffed04f3-5743-4a92-9b2c-20887c04a4cf@sandeen.net>

On Tue, Mar 18, 2025 at 07:58:05PM -0500, Eric Sandeen wrote:
> On 3/18/25 6:51 PM, Theodore Ts'o wrote:
> > On Tue, Mar 18, 2025 at 03:39:33PM -0500, Eric Sandeen wrote:
> >> generic/699 fails because _overlay_mount_dirs() uses _common_dev_mount_options(),
> >> and when FSTYP is ext4, that yields "-o acl,user_xattr" and acl is not a valid
> >> option for overlayfs.
> > 
> > Hmm, I hadn't noticed because the test is getting skipped for me:
> > 
> > BEGIN TEST 4k (1 test): Ext4 4k block Tue Mar 18 19:44:51 EDT 2025
> > DEVICE: /dev/vdb
> > EXT_MKFS_OPTIONS: -b 4096
> > EXT_MOUNT_OPTIONS: -o block_validity
> > FSTYP         -- ext4
> > PLATFORM      -- Linux/x86_64 kvm-xfstests 6.14.0-rc2-xfstests-00063-g6630cf085eb0 #14 SMP PREEMPT_DYNAMIC Mon Mar 17 11:19:56 EDT 2025
> > MKFS_OPTIONS  -- -F -q -b 4096 /dev/vdc
> > MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity /dev/vdc /vdc
> > 
> > generic/699        [19:44:51][   12.536740] run fstests generic/699 at 2025-03-18 19:44:51
> > [   12.794084] overlay: Unknown parameter 'acl'
> >  [19:44:52] [not run]
> >         generic/699 -- overlayfs doesn't support idmappped layers
> > Ran: generic/699
> > 
> > I haven't really played with idmapped mount.  Is there some CONFIG
> > option I need to enable this test to run?
> > 
> > 						- Ted
> 
> I shouldn't have said "failed" - you're seeing what I'm seeing, it's 
> skipped (not failed) because it tries to test overlayfs idmapped layers
> using the ext4 default options, and acl mounts fail, skipping the test.

How about changing as below?

diff --git a/tests/generic/699 b/tests/generic/699
index 620a40aa..3ca92254 100755
--- a/tests/generic/699
+++ b/tests/generic/699
@@ -100,7 +100,8 @@ reset_ownership()
 setup_overlayfs_idmapped_lower_metacopy_off()
 {
        mkdir -p $upper $work $merge
-       _overlay_mount_dirs $lower $upper $work \
+       # Ignore the MOUNT_OPTIONS isn't for overlay
+       MOUNT_OPTIONS="" _overlay_mount_dirs $lower $upper $work \
                            overlay $merge -ometacopy=off || \
                            _notrun "overlayfs doesn't support idmappped layers"
 }
@@ -109,7 +110,8 @@ setup_overlayfs_idmapped_lower_metacopy_off()
 setup_overlayfs_idmapped_lower_metacopy_on()
 {
        mkdir -p $upper $work $merge
-       _overlay_mount_dirs $lower $upper $work overlay $merge -ometacopy=on
+       # Ignore the MOUNT_OPTIONS isn't for overlay
+       MOUNT_OPTIONS="" _overlay_mount_dirs $lower $upper $work overlay $merge -ometacopy=on
 }
 
 reset_overlayfs()

> 
> -Eric
> 

