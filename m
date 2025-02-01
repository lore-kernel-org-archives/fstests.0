Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019741BD038
	for <fstests@vger.kernel.org>; Sat,  1 Feb 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738418362; cv=none; b=qz1GB60w+nJCs7Ruot66gN+Sv1VgLf6c7Tuffvig9YWR86OUGCP2GPEMFtorsDh2hC+BPQ8V2FAeJHSzW94D/nC61AhsZeCPgJX7St50f2Y54yQrwWLFhEHiOULaVJGeetCTrzdwM7LYsCf4zBBXtDSvbamKvb3IwlgME8JAwNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738418362; c=relaxed/simple;
	bh=pR8WH26X/q6U0n9NkepNBT2vkGEmvYiSI+DcipTEhck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVMW0gL4lnwW9Dayt5Pcajub9esFi19Cg23QDt1qibXcNowf6XeTq6iv4FZFGVX8sgSU8uRXWzq6Shv/u83/LhpL4jRbKR9HEZgbLlQKnAsYbzm+S3yMJl3pvQadPPhMNataxSStJM6/ZBHnek+wbhD5RPo1beAbhg+gssYIUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PqAU7OYm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqAU7OYm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738418358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qmAZARzJ9C1n/FGsYnWAiWXYV8MPOjHykZI8ROUvWqs=;
	b=PqAU7OYm5RIQngJ5Wcy6xLzM5+RH0V0+jdLBkmmXDfQXlu0SR9sqt3lULWaKnP1SmfyT5G
	hrs//0hRxshDuWdZDy69Hcw3KgrPrtt8sT1OHET4KRb/peA8eicEXPVPxHwwZNX7lIBFc6
	i+3smFOP6pVezDXWb+QlnFpGRTYQvIA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-vIvPGWloNxicRtd_OghlnQ-1; Sat, 01 Feb 2025 08:59:17 -0500
X-MC-Unique: vIvPGWloNxicRtd_OghlnQ-1
X-Mimecast-MFC-AGG-ID: vIvPGWloNxicRtd_OghlnQ
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216717543b7so113495ad.0
        for <fstests@vger.kernel.org>; Sat, 01 Feb 2025 05:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738418356; x=1739023156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmAZARzJ9C1n/FGsYnWAiWXYV8MPOjHykZI8ROUvWqs=;
        b=YZEEPCYRSaQJO7JhSmJorO6pFS/Vy/D1aC/jV3wjjlcFM1otv6leChuYGxMDy1vHFT
         MP6Pto/7+EoXvSJwx8wvJqsndYIu0LV++6crIWOphIjGIIv1jxavrQMF8EDa9Fi5+gdA
         1+Ftw7E69vCi+GFD2qLTTGmFgd2vxSopRR3K49Cx8aeGgLqzAHbsNnba6a1bMimXuzo6
         u0iGPlq04zOWOJ1WxHjJdRN74klKws+uCreMyR3xlEroLYNx3BjAY2tPg1vjSN5ZLl+1
         KqstmHmwKUx2Kbpa8XdVRLpTU4tzRUMjAiR+t5NpGrkF4MrWTy9HZhmTrxp1A2I7taPu
         eWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjbqmbi9vYm+Q1zba5XuIqvMj4I2IAQRUd5chiGpMzJ5t/FbSKyHvFNeVMkXgNWvqNy5LrJrKa@vger.kernel.org
X-Gm-Message-State: AOJu0Yze/D0mR/SW3ds+uSG6tt8iWosiB+W1rdyd6vR0vqK6fDxYc2G7
	o5eEpbxfnJ8hjmagV5ab2tg6sc4m4/DpxRvQ7nJWrpfvEO08hED5VD1O003e62g+uQP6H1YwHBf
	DddqTxmrZZmT5HlKoLvx8W7dd8Q2j+ylfZ0c3lO8XJxRMnyPyWg9W/zY=
X-Gm-Gg: ASbGncs5/20UymDR7mDgLKrvYvjEdsjEkrqmZ5qHWMRJydVT+y8olYsqgChljXKdoxa
	Jeku6n/t6ZRVXwQi+MRPdAId0JnitE6o8IesZhQiqCGqBOfQ3x/KRepIIYXnSnuJhQRmzLDLBJA
	q9MdSQFCgFU1GBsxAOyFq8q9T2ygD0MXp9sEH1inoRfgpz1MbC4FFeRxX3Wtg8NdTWFFYPn7K6c
	ImilbUdTbZxBQm65cBKsLrV9TiKCRR9/DcqMiFqfEtgN7e8doav637Qv96O0m6nVjSLi9vafsAw
	cvgQad8jPKLwr4SPGYQek3vnSsmYhJZ+bo0uZXmi0oJVyg==
X-Received: by 2002:a05:6a20:a11d:b0:1e0:b5ae:8fc1 with SMTP id adf61e73a8af0-1ed7a5fafdemr26217620637.13.1738418356659;
        Sat, 01 Feb 2025 05:59:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHa6kINL9tUbJBGdL5T5/HJd95XDU5gIp4rlzFG1OgLBs29JAPIoJiyApA80q1AgHnhAi66WA==
X-Received: by 2002:a05:6a20:a11d:b0:1e0:b5ae:8fc1 with SMTP id adf61e73a8af0-1ed7a5fafdemr26217568637.13.1738418356291;
        Sat, 01 Feb 2025 05:59:16 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba322sm5054412b3a.110.2025.02.01.05.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 05:59:15 -0800 (PST)
Date: Sat, 1 Feb 2025 21:59:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Day, Timothy" <timday@amazon.com>, Andreas Dilger <adilger@ddn.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jsimmons@infradead.org" <jsimmons@infradead.org>,
	"neilb@suse.de" <neilb@suse.de>, fstests <fstests@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Message-ID: <20250201135911.tglbjox4dx7htrco@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
 <Z5h1wmTawx6P8lfK@infradead.org>
 <DD162239-D4B3-433C-A7C1-2DBEBFA881EC@amazon.com>
 <20250130142820.GA401886@mit.edu>
 <4044F3FF-D0CE-4823-B104-0544A986DF7B@ddn.com>
 <CAOQ4uxgpDy-WFJgpha38SQxSYZDVSaACexJ5ZMr2hN7XkzsBqQ@mail.gmail.com>
 <1A60CCB2-5412-4223-849C-F6824F82B1B2@amazon.com>
 <CAOQ4uxjR2fD1gUY6NnJa75+ACm_nANNPajmH5aaVSN7FoD8ukQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjR2fD1gUY6NnJa75+ACm_nANNPajmH5aaVSN7FoD8ukQ@mail.gmail.com>

On Sat, Feb 01, 2025 at 11:55:21AM +0100, Amir Goldstein wrote:
> On Sat, Feb 1, 2025 at 12:01 AM Day, Timothy <timday@amazon.com> wrote:
> >
> > On 1/31/25, 5:11 PM, "Amir Goldstein" <amir73il@gmail.com <mailto:amir73il@gmail.com>> wrote:
> > > On Fri, Jan 31, 2025 at 3:35 AM Andreas Dilger via Lsf-pc
> > > <lsf-pc@lists.linux-foundation.org <mailto:lsf-pc@lists.linux-foundation.org>> wrote:
> > > >
> > > >
> > > > As Tim mentioned, it is possible to mount a Lustre client (or two) plus one or
> > > > more MDT/OST on a single ~3GB VM with loopback files in /tmp and run testing.
> > > > There is a simple script we use to format and mount 4 MDTs and 4 OSTs on
> > > > temporary loop files and mount a client from the Lustre build tree.
> > > >
> > > > There haven't been any VFS patches needed for years for Lustre to be run,
> > > > though there are a number patches needed against a copied ext4 tree to
> > > > export some of the functions and add some filesystem features. Until the
> > > > ext4 patches are merged, it would also be possible to run light testing with
> > > > Tim's RAM-based OSD without any loopback devices at all (though with a
> > > > hard limitation on the size of the filesystem).
> > >
> > >
> > > Recommendation: if it is easy to setup loopback lustre server, then the best
> > > practice would be to add lustre fstests support, same as nfs/afs/cifs can be
> > > tested with fstests.
> > >
> > >
> > > Adding fstests support will not guarantee that vfs developers will run fstest
> > > with your filesystem, but if you make is super easy for vfs developers to
> > > test your filesystem with a the de-facto standard for fs testing, then at least
> > > they have an option to verify that their vfs changes are not breaking your
> > > filesystem, which is what upstreaming is supposed to provide.
> >
> > I was hoping to do exactly that. I've been able run to fstests on Lustre
> > (in an adhoc manner), but I wanted to put together a patch series to
> > add proper support. Would fstests accept Lustre support before Lustre
> > gets accepted upstream? Or should it be maintained as a separate
> > branch?
> >
> 
> Up to the maintainer (CC) but in any case, you will need to maintain
> a development branch until the fstests patches are reviewed, so I do
> not see much difference for the process.
> 
> My own vote would be to merge lustre support to fstest *before*
> merging lustre to linux-next tree (to fs-next branch), so that lustre
> could potentially be tested by 3rd party when it hits linux-next.
> 
> IMO, if lustre is on track for upstreaming with all the open questions
> addressed, I see no reason not to merge fstests support earlier.
> 
> I was going to recommend that you consider adding lustre support to
> one or more of the available "fstest runners" to provide a turnkey solution
> for the standalone test setup, but I see that you already contributed to ktest,
> So that's great! and one more reason to merge fstests support sooner.

Thanks Amir, I think fstests has nothing to lose to support one more testing :)

Let's see the patchset (to fstests@) at first. If it's simple enough, likes
4cbc0a0fa8b ("fstests: add GlusterFS support"), then it's easy to be merged.

If it needs to change many common things or generic cases, we'd better
to give it more reviewing and testing, and maybe merge it into a separated
branch at first. Anyway, let's check the patches at first :)

Meanwhile, I'd like to track the patches you send to linux VFS, to think
about when it's time to have the testing part at first, so feel free to CC.

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 

