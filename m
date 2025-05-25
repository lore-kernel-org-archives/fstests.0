Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8609143895
	for <fstests@vger.kernel.org>; Sun, 25 May 2025 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748151376; cv=none; b=N8NodptBgTYB/MfwCNwiXoBIPw7WMRDeRfqYg/E6dheRjDpz8K5tw4n/zx2kiyWw/f3SfTf73fIilW2VsKgQxQxHl1HOi5zh+qQQpkspOMRIcjA0rMHNS/gOlNETLaMcysHY9yvm5jgNR4olpC+p5SbGJI75tpFx2WnzusMKTX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748151376; c=relaxed/simple;
	bh=OirI05qR7ck3OFB26hMON/z/D2766a98LkF/Eb6ntbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5bKcN1O9GmjNt6wZwImPqp9Tn+TCUrLPR9p7rLud++FsVljVsQ38+6iKL1LJ5gqGlNxEf2KdmqYshE5p9t3w/ap9ldW2fdJXP//5TU9zZF3iQTYOPuVuImQ0znH40g5Zx6cAne1r2qhclwUjITrZ9bGNGIq60luQ+uS3+j2zW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2dLAZP9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2dLAZP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748151373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOSluJwjmK7UyYxNHzzRZbBEhS7j+uYg9GZHFodmdfE=;
	b=D2dLAZP9xly81Kc+Ofb4tdLYhRQJBzvnDEeI1NmRoX/xQ/A0xvTG7r+Ube2TsLeJGmyKDt
	R53pr2BtoxzfphpVyrqmJ9Je7vOwrgouX+A2UjmWJrt+RFLAXirzBk5FnYsInwR+bDlp7L
	nhDeGIBg1rUtzKqOvZ9lT+IHiDTWG1U=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-3Sov5B4COBWHPDEmdYPpmw-1; Sun, 25 May 2025 01:36:11 -0400
X-MC-Unique: 3Sov5B4COBWHPDEmdYPpmw-1
X-Mimecast-MFC-AGG-ID: 3Sov5B4COBWHPDEmdYPpmw_1748151371
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2371b50cabso1279991a12.0
        for <fstests@vger.kernel.org>; Sat, 24 May 2025 22:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748151370; x=1748756170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOSluJwjmK7UyYxNHzzRZbBEhS7j+uYg9GZHFodmdfE=;
        b=GwBXvZPYb1dtU+WUuLLKlM96ApdjCvO+ksdXStjm0Ay3/gXOJaTL9AEFSpGiNnD0Rv
         0ykq4gPpjqYCSaL+4kWh+Ttk/gDWThqDPjeBNPwRmVhk6NiFErfHUjAiymaJlkREH5Le
         ZO5S8L7ytv7hY0At6XhL9sLocXxDySPYvRov818A7qLieQr/IZBxpj3STjhDWkp9TyCO
         PrO4fCs3jF6LMdETPg2/6m8BFtVQnPEcxiO6PWXBc2owk/YYFcRfda4HGocEXtxMNMCX
         0AI5HW1q95Vy5iYVYU6Rl9qzQjQqF5KooeprdPLwt/1cRp5mebZYpFGatdr3cXw3NF7l
         a5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUKFirj4zMgYf72PKVnL6uyWCJJV5Fd19s8iztW++Gg6oH4V9ajZo1Iy26Hh6snDtf3lAbzT6u@vger.kernel.org
X-Gm-Message-State: AOJu0YzBetWl7iIepgg+CshJHBLLel1l0Daq+5fDLzrqa23G8uNOj5My
	lQcRGjp0DD3wDfuCHuVIBTJEwGyg0VshQ2cARur+SPneHISvtCpJa2DAhCD+APS2gRUtiWZbWUI
	v0n4Oz+nSiC56tQvdmfMtuahsNebovbbSNUZJtFYJ8ZOWH42lX9eXN5KlQBg=
X-Gm-Gg: ASbGncssTgX7xmd/fgPOzLJBwnoovwnrwET6owShuZjlgNDCRqvH0ikYTP0zZJH/jqb
	clLwBh6n0YuJh/IldGoxg6GrUQ+rsf/mXTDyz+Cj+s10r8rGe2XdsPeEW1wm3DDTQkv4EoGBImx
	zOu1pZJeUDTNvmXcRKpkq6/U/dHnAZNuAFjFTryxXuYkovroI8mEUYy8J0sgwKP7uCyhRuQNBjF
	NTOuZ9s2QodotGxmyGp4G2szFhBcu0OmJv5UNHdMh0cerUJukCTT3+tfq9sas1Ydv4NNtcwg1b9
	HcyOZ7IdXWMtUZ1TGEAK1hSQ4z+htcrFQJh2GiT8NQm+WqHLUJT5
X-Received: by 2002:a17:903:4b30:b0:231:d16c:7f55 with SMTP id d9443c01a7336-23414ea1745mr77248235ad.0.1748151370631;
        Sat, 24 May 2025 22:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHazE7+HZjBc2mKepljRO5it6kl6W1fcjqaVldXUGvejX6NK+ouRmImXIudkxA7rOXas01AdQ==
X-Received: by 2002:a17:903:4b30:b0:231:d16c:7f55 with SMTP id d9443c01a7336-23414ea1745mr77248005ad.0.1748151370252;
        Sat, 24 May 2025 22:36:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2344990db47sm2582475ad.62.2025.05.24.22.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 22:36:09 -0700 (PDT)
Date: Sun, 25 May 2025 13:36:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Tests for AT_HANDLE_CONNECTABLE
Message-ID: <20250525053604.k466kgfcumw2s2qx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250509170033.538130-1-amir73il@gmail.com>
 <CAOQ4uxht8zPuVn11Xfj4B-t8RF2VuSiK3xDJiXkX8zQs7BuxxA@mail.gmail.com>
 <20250523145028.ydcei4rs5djf2qec@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxhxvHpfrd5BVKLFYr3D8=v4z1js-XkcODRhXtr0-tsecw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhxvHpfrd5BVKLFYr3D8=v4z1js-XkcODRhXtr0-tsecw@mail.gmail.com>

On Fri, May 23, 2025 at 07:11:23PM +0200, Amir Goldstein wrote:
> On Fri, May 23, 2025 at 4:50 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Fri, May 23, 2025 at 04:20:29PM +0200, Amir Goldstein wrote:
> > > Hi Zorro.
> > >
> > > Ping.
> >
> > Sure Amir, don't worry, this patchset is already in my testing list.
> > I'll merge it after testing passed :)
> >
> 
> Thanks!

Hi Amir,

Although the v2 test passed on tmpfs, but it still fails on nfsv4.2, the
diff output as [1]. Is that as your expected? Anyway I think this's not
a big issue, so we still can merge this test case at first (as it's blocked
long time), then fix this failure later :)

Thanks,
Zorro


[1]
--- /dev/fd/63	2025-05-23 17:25:52.283688434 -0400
+++ generic/777.out.bad	2025-05-23 17:25:51.955645147 -0400
@@ -1,4 +1,34 @@
 QA output created by 777
 test_file_handles after cycle mount
+open_by_handle(/mnt/xfstests/test/nfs-client/file000000) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000001) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000002) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000003) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000004) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000005) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000006) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000007) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000008) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000009) returned 116 incorrectly on a linked file!
 test_file_handles after rename parent
+open_by_handle(/mnt/xfstests/test/nfs-client/file000000) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000001) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000002) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000003) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000004) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000005) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000006) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000007) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000008) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000009) returned 116 incorrectly on a linked file!
 test_file_handles after rename grandparent
+open_by_handle(/mnt/xfstests/test/nfs-client/file000000) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000001) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000002) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000003) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000004) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000005) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000006) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000007) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000008) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000009) returned 116 incorrectly on a linked file!

> 

