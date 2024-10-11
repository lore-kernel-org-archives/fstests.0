Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6DD1BD509
	for <fstests@vger.kernel.org>; Fri, 11 Oct 2024 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728626628; cv=none; b=Lunm5VTGwNPPHWbv2j2Whzp3HsLny1JmMw9YowU0qTEBCL9sz/snu15wDPlZL61p04YVguiTUnuBfZuinAb8xid6PZAjTTPPDW1dSpy7dES2eh1f4WHxyJL8viNmb2Wg777/2W0MhiPJpVBVSf8TJwhXAmDHI0I8Wg22aeJz1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728626628; c=relaxed/simple;
	bh=QDXJAmwuwfSXQE9yJNTk/wPHrDnNL7cl57QTOy7Zfvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQ/IOyAScceHuEgPpB0pYGryuvmC6ZLI+g9xYUR7ldKUUWz7LQVoVGgF7t4CTcH551gTPUsTN666okoex7kFMWtsM2e8wWRSSuHtKUnAZd3Zw9oFKavM2FshihYQXvVOB6ZDBTiCUNgjdoV5ZVtaNASchhkd9373UkkA8AUUp5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVRULlfs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVRULlfs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728626626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNOt0E/5RL2wxiEQJo+eWfOtUiT+yir2w9lQbR/6FOo=;
	b=MVRULlfsMq8b9gQD0Crv0iJ1oyq9F1E7YbuW4yxHIu8QqoXDXV+g7gSGKVbr/HZFVLornz
	BKYOgRgv7KTK2dS+6qmYuoNuFZEWeEA6uv0Be+csqGrPVPY9NvRFLj2iZnXAm6Kab0JRkE
	8MpKk2ssURS+tisR2/UIvNIR3j4hheE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-Uc2vINfEP0Gwvk--YLB1ag-1; Fri, 11 Oct 2024 02:03:44 -0400
X-MC-Unique: Uc2vINfEP0Gwvk--YLB1ag-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7ea59e7fb29so246225a12.2
        for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 23:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728626623; x=1729231423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNOt0E/5RL2wxiEQJo+eWfOtUiT+yir2w9lQbR/6FOo=;
        b=JTMAjstBBJlz2qo5kFx3+WlCS0mg2WkLH5MCOjM931uA2SmwDi4EQV5sPZCMtFAb6A
         ZuX4rdBS0wrBCArRlJ5oa382IyZcKK84GGJ/7b/i3CVgC7wNAEZ4Y27JMWMC2b2yZ9aU
         fnUrWPKYJTr/5fH0BldMHo4Mm/ArAASBAd4BrXfNhhVL8qSRDqffLfKXSKO8DgLYOADg
         4nvR/VNrv782J/ekn8OZFOKno3lcfJYfvHr6fVANsju55bTuk7QFmfjWVOvtAVaDN8Pb
         UkKf44Az3KLC1a4ocxVn97Xyf0pWD7X3BsHWlfj3jtV9K1CRqJ2oGMaxOzco1vDOEC4b
         Jyfg==
X-Forwarded-Encrypted: i=1; AJvYcCW7ntG0r9oh9vuRRrwp+9GgOG0vgT3bFMjjTodsNo2e/V1OqW3DOQyFRhhB5LYq9uwSlZrMG9aX@vger.kernel.org
X-Gm-Message-State: AOJu0YyyGfxKtXFTPLRzGgOOfeRZg5RcdVXmtYWusuP9+tsgSsRaUb+i
	qSbPn/3uWnSOJzprFwf7Ti0n9lw/HigAHWJLTYEecGEN1mF34CJ71N2uosF/qlu9QLS+A4D1xQ/
	uisUOOSbI8sd7mxdVHBBmPq3goQOTZmQVRcHO63McLuYxl5x1WFPIhZc7e58loC9Dhg==
X-Received: by 2002:a05:6a21:2d89:b0:1cf:2a35:6d21 with SMTP id adf61e73a8af0-1d8bcfb3cf1mr2395836637.45.1728626622952;
        Thu, 10 Oct 2024 23:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB4ai7iszbD9EgiEJNygp361aZwt973dHvNZhFIBxJlqvwzY+ObZhiT+nKK3HO8gUGynL2rQ==
X-Received: by 2002:a05:6a21:2d89:b0:1cf:2a35:6d21 with SMTP id adf61e73a8af0-1d8bcfb3cf1mr2395804637.45.1728626622655;
        Thu, 10 Oct 2024 23:03:42 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa9388dsm1962079b3a.130.2024.10.10.23.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:03:42 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:03:38 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: An Long <lan@suse.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/315: update filter to match mount cmd
Message-ID: <20241011060338.amcgqjgz37ju54fi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <29dc7fdf9dd8cfb05ece7d5eb07858529517022f.camel@suse.com>
 <20240923133011.cmv63zpd3yg37yw2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H4f4-3=0OUwYQiFC3hDY=k3SDUsGEJm1S7iro5+pD9yyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4f4-3=0OUwYQiFC3hDY=k3SDUsGEJm1S7iro5+pD9yyw@mail.gmail.com>

On Mon, Oct 07, 2024 at 01:11:35PM +0100, Filipe Manana wrote:
> On Mon, Sep 23, 2024 at 2:30 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Mon, Sep 23, 2024 at 03:57:13PM +0800, An Long wrote:
> > > Mount error info changed since util-linux v2.40
> > > (91ea38e libmount: report failed syscall name).
> > > So update _filter_mount_error() to match it.
> > >
> > > Signed-off-by: An Long <lan@suse.com>
> > > ---
> > >  tests/btrfs/315 | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tests/btrfs/315 b/tests/btrfs/315
> > > index 5852afad..5101a9a3 100755
> > > --- a/tests/btrfs/315
> > > +++ b/tests/btrfs/315
> > > @@ -39,7 +39,11 @@ _filter_mount_error()
> > >         # mount: <mnt-point>: fsconfig system call failed: File exists.
> > >         # dmesg(1) may have more information after failed mount system
> > > call.
> > >
> > > -       grep -v dmesg | _filter_test_dir | sed -e
> > > "s/mount(2)\|fsconfig//g"
> > > +       # For util-linux v2.4 and later:
> > > +       # mount: <mountpoint>: mount system call failed: File exists.
> > > +
> > > +       grep -v dmesg | _filter_test_dir | sed -e
> > > "s/mount(2)\|fsconfig//g" | \
> > > +        sed -E "s/mount( system call failed:)/\1/"
> >
> > Oh, there's a local _filter_mount_error() in btrfs/315. I thought you can
> > change the common helper _filter_error_mount() in common/filter. So maybe
> > you can merge this _filter_mount_error into that common helper in another
> > patch, then other test cases can use it.
> 
> This patch missed the last update.
> Was the cleanup to use the filter from common/filter required before
> merging this?

Thanks Filipe, I'll merge this patch at first.

Hi An, this patch has same issue with the other one you sent recently:

  $ git am -s ./v2_20240923_lan_btrfs_315_update_filter_to_match_mount_cmd.mbx
  Applying: btrfs/315: update filter to match mount cmd
  error: corrupt patch at line 12
  Patch failed at 0001 btrfs/315: update filter to match mount cmd
  ...

They all have "corrupt" data, maybe you can check the way you generate and
send patches, better to not change the .patch file manually before sending.
I'll merge this patch manually to catch up the release of this week, so
don't need one more version :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Thanks.
> 
> >
> > Thanks,
> > Zorro
> >
> >
> > >  }
> > >
> > >  seed_device_must_fail()
> > > --
> > > 2.43.0
> > >
> > >
> >
> >
> 

