Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35346276D12
	for <fstests@vger.kernel.org>; Fri, 28 Feb 2025 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727637; cv=none; b=PNxUiG+toj9NDERjJt90XTVOWWJM+ZYF9+7nQVCT1alLHyrfBUkpmrjMYKS2CrCsZeG6futOgig4Eb3zEv6wRjAtSmeiI8jipC0BPFVv6T7Ii+Gm4TrZ0TxZDxaaaYAr5c1tfwNc0mnsp+lGHl6AnizrMvTXhORaZfc9w2soFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727637; c=relaxed/simple;
	bh=OXaRp4idgcRdJx0qDoj8i90oCscA5SqQ9u7Mn4MPzwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa95jXKYuIcwJFn7avjVI8o9Doc8MtEVdZhYtCZ01KDoA+qFC2ehDympBuhLzvcpNzC7m4fjulm+BCdwLgRaTqI7L2bhGeZeyN+86cq3tkZ8RHIrwGEtiZk68U6lTJKD4QFTSdnBPXiL6Hzcwxc6vzUk8+TP5P3925U+1R/fK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UWrvOQqE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UWrvOQqE"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb7f539c35so332257566b.1
        for <fstests@vger.kernel.org>; Thu, 27 Feb 2025 23:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740727633; x=1741332433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfdNaB0E7fgmIJmDaEv9xRcyfj8vJkDTlr4miGhmJ1s=;
        b=UWrvOQqEJQOAboP8Df7TAyKhcxXrW4PFVYWt5k7HutjJFwm0kxyME1MUzLbSQnkDd3
         XhOgjwkNV0qjw8oywFPL88Ikj+zCVW5yEiO6sUQcvvNFr8116D2E/jFP0DLysHfnec/q
         AVCx90EHRYU3jGUVZ8CBeE8oUlqhvdWA/ruRI2MAbHVPglSTB646owrtrVcgqrHCrhB3
         17743nHfhPs7uoyWR1G2w9rEA3uoPVaFMpiub/ZaQu/oX0NqnjmJ0CBA8tz/MXU2hFZx
         b8kz6W1ICqicIkqycDW/V4jqUjeNi3l8CFiZanIpak9GeHYBfidm5hhVozrq0CDxgGjB
         8TPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740727633; x=1741332433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfdNaB0E7fgmIJmDaEv9xRcyfj8vJkDTlr4miGhmJ1s=;
        b=LGknNn/RFW4VlpIKL3PtDLH7dAcRDq50RVkBxQ/QhxZDsr1lQS0Josyrggt5lRKZ7s
         LwTQLUUZid5e/dEEhfaOPuIIBnI44/ZD5y8s11xsom2wC4gkwqIth53faV7XMf0ojgF1
         JF381eoZDWBdGEbRi+f3Z5jKH4txExhjUtL8NZ0pCWBC7911XmvBOBw3r9tI+Ie9ARjJ
         92yubs8Kfu0fX0IAgPePngGFJARS5zNc+d77gc4qrdJz2A6t85tmxEb5zrLT37SCOGPd
         5VBU3yIINrppbI9zPULnljrFq6LLRfPb3XckjmKKfdxyR6bnqQqbmZOzDGqENjH0Esj8
         ZFaQ==
X-Gm-Message-State: AOJu0YyTibFtMavfRADd7+7bvru9NSC/Z9mho4J7Vgl0Vh1XqTycm8vB
	eOHZPwIRJSYrKOLg2aQpo3KmkpW3gVkNDYK3dALPS84fsobth5pIoXsdofWs23DsbEbQ3euqimY
	Gx9wvXVxJVwmpBfut8K7F5zyE7Y4zRG+8M95o2A==
X-Gm-Gg: ASbGncsdlBKs+XYMDlppjhJNfpfNRtPJBb/b0egPlOZpvjEdKGn+3S5oiRmuUpJqSSU
	qgGxqMMFfPxq2KmmGpRQIg6XAuFVeVxb3Ctp+7m1e9GZzZg4mjRw8FxN9SSc6V8y9piLAvMWwsD
	/hB2uQag==
X-Google-Smtp-Source: AGHT+IEHZLuLqzLU6YdSbwrSc2pWAVvyIXo9LRUSqmihktMu9s8+x868QHVGvuWQwKCXqHeHI81dd93VpPypCBDhMZI=
X-Received: by 2002:a17:906:f59d:b0:ab7:a5f2:ed22 with SMTP id
 a640c23a62f3a-abf25fa0374mr268651566b.1.1740727633443; Thu, 27 Feb 2025
 23:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220145723.1526907-1-neelx@suse.com> <20250224111014.2276072-1-neelx@suse.com>
 <CAPjX3FeKPR78zfUYGW+8Ytn-Yz+7i7k+1vmxjO6wjDcobqtocg@mail.gmail.com> <d618b303-4753-40cd-b02b-026437abdfa6@oracle.com>
In-Reply-To: <d618b303-4753-40cd-b02b-026437abdfa6@oracle.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 28 Feb 2025 08:27:02 +0100
X-Gm-Features: AQ5f1JptISSwH9o8Im_GI3JkMuHyJ2I1tTf4FzdUl7ZNwowAMjXGr77skWSlxfo
Message-ID: <CAPjX3FcY7uc5mP8z5VMDS0tfrVP87O0q6jQkXY3OAq9stWvfCg@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/314: fix the failure when SELinux is enabled
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Feb 2025 at 07:10, Anand Jain <anand.jain@oracle.com> wrote:
>
> On 24/2/25 19:35, Daniel Vacek wrote:
> > On Mon, 24 Feb 2025 at 12:10, Daniel Vacek <neelx@suse.com> wrote:
> >>
> >> When SELinux is enabled this test fails unable to receive a file with
> >> security label attribute:
> >>
> >>      --- tests/btrfs/314.out
> >>      +++ results//btrfs/314.out.bad
> >>      @@ -17,5 +17,6 @@
> >>       At subvol TEST_DIR/314/tempfsid_mnt/snap1
> >>       Receive SCRATCH_MNT
> >>       At subvol snap1
> >>      +ERROR: lsetxattr foo security.selinux=3Dunconfined_u:object_r:un=
labeled_t:s0 failed: Operation not supported
> >>       Send:      42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfs=
id_mnt/foo
> >>      -Recv:      42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/f=
oo
> >>      +Recv:      d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/f=
oo
> >>      ...
> >>
>
> It=E2=80=99s actually good that the Btrfs receive failed because the send=
 had
> an unlabeled security context=E2=80=94kind of a validation, even though i=
t
> wasn=E2=80=99t intentional. The fix here fits the objective of the test c=
ase.

It's the other way around. Send (missing the mount option) had the
label (as expected) which was refused by the receive side due to the
explicit context mount option. That's how SELinux is designed.

> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
> >> Setting the security label file attribute fails due to the default mou=
nt
> >> option implied by fstests:
> >>
> >> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/sdb /mn=
t/scratch
> >>
> >> See commit 3839d299 ("xfstests: mount xfs with a context when selinux =
is on")
> >>
> >> fstests by default mount test and scratch devices with forced SELinux
> >> context to get rid of the additional file attributes when SELinux is
> >> enabled. When a test mounts additional devices from the pool, it may n=
eed
> >> to honor this option to keep on par. Otherwise failures may be expecte=
d.
> >>
> >> Moreover this test is perfectly fine labeling the files so let's just
> >> disable the forced context for this one.
> >
> > And of course I forgot to remove this sentence. Please, remove it if
> > you decide to merge this fix.
>
> Fixed the changelog and pushed it (for-next).
>
> Thanks, Anand
>
>
>
> >
> >> Signed-off-by: Daniel Vacek <neelx@suse.com>
> >> ---
> >>   tests/btrfs/314 | 6 +++++-
> >>   1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> >> index 76dccc41..29111ece 100755
> >> --- a/tests/btrfs/314
> >> +++ b/tests/btrfs/314
> >> @@ -38,7 +38,7 @@ send_receive_tempfsid()
> >>          # Use first 2 devices from the SCRATCH_DEV_POOL
> >>          mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> >>          _scratch_mount
> >> -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> >> +       _mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${t=
empfsid_mnt}
> >>
> >>          $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter=
_xfs_io
> >>          _btrfs subvolume snapshot -r ${src} ${src}/snap1
> >> --
> >> 2.48.1
> >>
>
