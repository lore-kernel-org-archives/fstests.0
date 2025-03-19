Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D851EEB1
	for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398755; cv=none; b=UeXCMIm2qUaRNqLqGnMBomQL7uIZmPqKntMmRTYyjbOPUa+/xs4eYGKhKfouiOOFFRqCZJGAhraf7wnoMkxuILUmFoAU/rBmkrdE/lX1ocltGU1KbYcz56jhKjFjL8aU81j3ACUEW7O7ODNWdhxMrd9PcFK0+u1Zu8LKzkkEF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398755; c=relaxed/simple;
	bh=Y01v1mEt9ywF0E2D5WIeOC9XmDAOYFKw3l9u2Cxs54U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6rVi3vIjn+NTgeFucKFpwUcacIqAfZlTXhLZ5bqco+DZ3i0OvWvp4U595kHBWYvsF3dZafkNsO1pgcUDiTbpbLfC1AexB2MI3p2XOVWZ8250qEY3quFX+Y92mj2z/AgQvlcF6A8ORDnzykfK8zxVRe/P7XiF+fP0V+wGhV482I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WztGgsK8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WztGgsK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742398753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GLMyutKCKPjWXkeqT8o7E4/+utU9faB0IoKq3uoVGV0=;
	b=WztGgsK8Xp1lunoO0YuxJsyqCBaUKbFyQoPF/nFXRwMkKBTgfreBW/CS+SZL5YfRPvF5RD
	qQOfvy5Kk2Ucxhf95kNEriPo2va9Gvj44IsekCDwZgUux0TQvKwlKyeiZi0XNfsaixWIl3
	AlnoQCigxUjYRpw2Bnf9blpFeCPACco=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-fY-IN6hbM-ywVu2GRGMEBw-1; Wed, 19 Mar 2025 11:39:09 -0400
X-MC-Unique: fY-IN6hbM-ywVu2GRGMEBw-1
X-Mimecast-MFC-AGG-ID: fY-IN6hbM-ywVu2GRGMEBw_1742398748
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-225107fbdc7so113054385ad.0
        for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 08:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398748; x=1743003548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLMyutKCKPjWXkeqT8o7E4/+utU9faB0IoKq3uoVGV0=;
        b=ZtjtggNbOF32iiSO89nOJjemy23LEGojuopTvrpu7KUlE01sP90fBXro47RlSrvLoz
         odVcw+f2UzyrO9j+Dmev40pKffjkcj40gHi9Fa5oUdG9eVTkjJ2IKlr4iFEoaky7zKE3
         gNH/c/vb7wnn/1ufOM2ocrv+Bx1MSJ9rPUhTu3xhcg3cycObpM2mKITDbjYc9aktgDqC
         2VA3BkqDjJTOqkZ4Xixw9wGDFswgGb5EpbV5uCQaAsnCchyVf0ogVzKb4PjzUXgbPX7M
         33+yD5cirws+juOyP7XNcBeN6X2BhMozQ6QaRr1gVA16oLWV86b+750pzuM3+II5oPTE
         wX2A==
X-Forwarded-Encrypted: i=1; AJvYcCXG9l04wT/YssM6muup/DWvbolPbh88f66l2/0+aMrK9OmDzNHscguYafEIWrtR5615dm36s+SD@vger.kernel.org
X-Gm-Message-State: AOJu0YzChjYd7Vi0ftBTet35RAoVN/UVCAWWTo4uXEFdBFgQJHxjDe9p
	SDPOVR2NLKQsgsoynxoGyBDC7Ps3DTT3XefYRn0WMH3O3iiAXst0DGH6kNKIa2osiIyZgrGHOXi
	y3DvY6xJFahOJ4TQPMHjRYglVPctOuJmEjSoWbF6bkxS8IddVuQ8KuoY=
X-Gm-Gg: ASbGnctahvgpvGvKMkZGJfLFxDg4iWwJs+U29oZWksuvpRy1EzQACTrwg1gcpag5IfG
	KXhK2AqSUJrWx737qh7+M4JMRBb0Mx9dYrq75kNc8Gi9EmJhr2cB/jk1qV6t1i2BYPgDq5UbSyl
	gKWxQgfWtRssfFoUf1eMsniLwIbgP7F/vr//9ecFDSOpAa5UuG1wVrhyxaKz+J2xjyzzRfK3tXG
	/EWpU+7E0bPjy1BU/p55nvLddvnPoda2d2ZxawMaMZscy6RER1L662dk7aMP8j9UmB2VzYZF5T7
	+715p7DirwrMXf7IacnrruLahEmSbpRsXLj0Ctl3Q5hNlNsDYtVgGz25
X-Received: by 2002:a05:6a00:2389:b0:736:3fa8:cf7b with SMTP id d2e1a72fcca58-7376d6495dbmr5203009b3a.13.1742398747928;
        Wed, 19 Mar 2025 08:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMR7envQIRsn7O5omssEszmkIiNyA8GI1DBWTR8/vluUuYKIpylSq8LHVcBQ6dYkjuiiDUNA==
X-Received: by 2002:a05:6a00:2389:b0:736:3fa8:cf7b with SMTP id d2e1a72fcca58-7376d6495dbmr5202974b3a.13.1742398747461;
        Wed, 19 Mar 2025 08:39:07 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9ddf4fsm10992412a12.21.2025.03.19.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:39:06 -0700 (PDT)
Date: Wed, 19 Mar 2025 23:39:02 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Sandeen <sandeen@sandeen.net>,
	Christian Brauner <brauner@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: generic/699 fails on ext4 due to using ext4 mount options w/
 overlayfs
Message-ID: <20250319153902.vn3xcttrrytrkfx3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c46d8caf-053a-4af1-b562-7ca7203cb926@sandeen.net>
 <20250318235116.GE787758@mit.edu>
 <ffed04f3-5743-4a92-9b2c-20887c04a4cf@sandeen.net>
 <20250319151144.3r27tjgenbzty5tr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319151144.3r27tjgenbzty5tr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Wed, Mar 19, 2025 at 11:11:44PM +0800, Zorro Lang wrote:
> On Tue, Mar 18, 2025 at 07:58:05PM -0500, Eric Sandeen wrote:
> > On 3/18/25 6:51 PM, Theodore Ts'o wrote:
> > > On Tue, Mar 18, 2025 at 03:39:33PM -0500, Eric Sandeen wrote:
> > >> generic/699 fails because _overlay_mount_dirs() uses _common_dev_mount_options(),
> > >> and when FSTYP is ext4, that yields "-o acl,user_xattr" and acl is not a valid
> > >> option for overlayfs.
> > > 
> > > Hmm, I hadn't noticed because the test is getting skipped for me:
> > > 
> > > BEGIN TEST 4k (1 test): Ext4 4k block Tue Mar 18 19:44:51 EDT 2025
> > > DEVICE: /dev/vdb
> > > EXT_MKFS_OPTIONS: -b 4096
> > > EXT_MOUNT_OPTIONS: -o block_validity
> > > FSTYP         -- ext4
> > > PLATFORM      -- Linux/x86_64 kvm-xfstests 6.14.0-rc2-xfstests-00063-g6630cf085eb0 #14 SMP PREEMPT_DYNAMIC Mon Mar 17 11:19:56 EDT 2025
> > > MKFS_OPTIONS  -- -F -q -b 4096 /dev/vdc
> > > MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity /dev/vdc /vdc
> > > 
> > > generic/699        [19:44:51][   12.536740] run fstests generic/699 at 2025-03-18 19:44:51
> > > [   12.794084] overlay: Unknown parameter 'acl'
> > >  [19:44:52] [not run]
> > >         generic/699 -- overlayfs doesn't support idmappped layers
> > > Ran: generic/699
> > > 
> > > I haven't really played with idmapped mount.  Is there some CONFIG
> > > option I need to enable this test to run?
> > > 
> > > 						- Ted
> > 
> > I shouldn't have said "failed" - you're seeing what I'm seeing, it's 
> > skipped (not failed) because it tries to test overlayfs idmapped layers
> > using the ext4 default options, and acl mounts fail, skipping the test.
> 
> How about changing as below?
> 
> diff --git a/tests/generic/699 b/tests/generic/699
> index 620a40aa..3ca92254 100755
> --- a/tests/generic/699
> +++ b/tests/generic/699
> @@ -100,7 +100,8 @@ reset_ownership()
>  setup_overlayfs_idmapped_lower_metacopy_off()
>  {
>         mkdir -p $upper $work $merge
> -       _overlay_mount_dirs $lower $upper $work \
> +       # Ignore the MOUNT_OPTIONS isn't for overlay
> +       MOUNT_OPTIONS="" _overlay_mount_dirs $lower $upper $work \
>                             overlay $merge -ometacopy=off || \
>                             _notrun "overlayfs doesn't support idmappped layers"
>  }
> @@ -109,7 +110,8 @@ setup_overlayfs_idmapped_lower_metacopy_off()
>  setup_overlayfs_idmapped_lower_metacopy_on()
>  {
>         mkdir -p $upper $work $merge
> -       _overlay_mount_dirs $lower $upper $work overlay $merge -ometacopy=on
> +       # Ignore the MOUNT_OPTIONS isn't for overlay
> +       MOUNT_OPTIONS="" _overlay_mount_dirs $lower $upper $work overlay $merge -ometacopy=on
>  }
>  
>  reset_overlayfs()

Oh, I rememeber this case now. Christian wrote a big test case to test idmapped
mount:
  https://lore.kernel.org/fstests/20220615092826.2333847-1-brauner@kernel.org/

That case tests underlying fs and overlay fs together. I helped to split it
to two cases, one for basic fs, one for overlay fs:
  https://lore.kernel.org/fstests/20220920115035.2472076-1-zlang@kernel.org/

I've forgotten why I left g/699 to generic, not in overlay. Maybe Christian hope to
run these two cases together in one FSTYP test round (don't need to run overlay test
once). I'm good to move this case to tests/overlay/, cc Christian to check his
review point.

Hi Christian, do you hope to move this case to overlay, or just roughly change it
as above patch?

Thanks,
Zorro


> 
> > 
> > -Eric
> > 

