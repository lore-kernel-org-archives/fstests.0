Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96A3F86E1
	for <fstests@vger.kernel.org>; Mon, 18 May 2026 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114463; cv=none; b=fupEXsLs/DvBzS9dfvcws+R4L178gMiuI53sjdfG9KnvrTjNlncCtKU9fCpFFMrWQlm3EzCRdfeXuFy5jJPyasR/F50AZdpuarUu12RvVKHQOYuiNXGnyjDQ3ISNPTxa+12/KO13J1HdDPXkxl6OEMwJI3/OmErWl1ViC0cI0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114463; c=relaxed/simple;
	bh=56sWDZSA5ZNIBjB/oNotI09lBuHC1nOmFFOAgN/NOPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAIUVBbObWpnhEVKgDuQQRv8nDZ58VjLsTsRWIvsxXPuFzDPDj8LeBENQFx1xRUCGwUc8W3PDgaGaLQ5JjkAZ5v19RrBfCCo5dumC13rxDXIHqZg5JkWrtCqT0oY7euYsup5/42YVfK3BdDZI8mDrTSL25/vBAMblZ1sYqdOJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bu1YOoyl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu1YOoyl"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so1083537a91.2
        for <fstests@vger.kernel.org>; Mon, 18 May 2026 07:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114460; x=1779719260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOAvfoTQyHNmhGQizKaH8ZeJlbp3fMLtJxwZtNlPMco=;
        b=Bu1YOoylQdoXGLSRGbc+FeNPAdYEXONPajxy10NEJ9/9pem+7ErubmIHLK8qYHYqbR
         M9BcN8nJmIj9WAtswHFYnL41+vyl/oFZ5K3YYQTU6yOhp10dNa3Z1lYLr9RYJuZ8bae9
         vu8SSalIxPwdicF3Zt+ROHKsdie6pYIpImxqhwsRcK5iQifVWH2fvg0LeJdH2wnnK1Y3
         C1Wxa+aZKUHS+1rTDROoxNsFgUe33Xt078+IE71KxRQXCZnLqpzTPqUOKUhUYNFzUKjB
         0Jf3BvfUG9VhqMRWI4UEOVIk0UPl+KDa3U/n3/H6eiydgdOwxwLziIPa4atUWkdVBo/v
         GaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114460; x=1779719260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOAvfoTQyHNmhGQizKaH8ZeJlbp3fMLtJxwZtNlPMco=;
        b=V/xC2mC0oZksruS1SMaAhSuHhr0o23AxdOJvRfos55a5lKEbwY0SElYpTDnbz6FcsJ
         UbX71XP0oXkYH8PyLWJuFAVIS7srdQ07iIerHOTT/ifEImWUDAdD172gyBdBqJxxQSvo
         e5EH0e0jAVY6JZdvZNvYtBJJhUXht4EGDIeeSwr5WYU2MwZt33qjIzUGTHJGTqfkvzfe
         xRK5oR4oCq8LnS1oCvn3NN0KUyMXuU0Zmw5kbu02Q7ub6fGr/lxU6sWesHeWmCgc1H9W
         f9ikei8XSFE6VNLEyYrSM6E0EyisuEgEgRk1Q1D2z1DsNwBtfP/Y0KZX5nnIxwrGcNue
         gzhQ==
X-Gm-Message-State: AOJu0Yz7qlP0PpHalYXmufJwF1PcPVSNBw1JuV4jelsxK2YOKqiWKaZR
	XsLOn9IxwOazbV1FJsxgtVa5A7at+UwFNdMovDtZZ+KBf11Q8Gs+4uLV
X-Gm-Gg: Acq92OEEwQ2okPgVNnpApW8IZjlTqjf7wPmkOiNh7wACkd0GFM1N70CxSKFxanDr9u2
	L7SM9tzrVVgCFnfxlwSIkua0o2BwORyZTBSOArQoGUvnSsKBBztMgsgJzqkj84h4K/zLvwGz7qO
	+WO4TIor+z6hwFMOWud6OchK0EZsSZjgcI+1A1g+Sr7O99LOoBfqM98vtwABEAU4AL2dE6MqccK
	/Rw26N37KnAgk4Ie2WrKJJCw/+QYo9v2VBJjVpU0yw+OJO3Az/rHVnMn7nT7COTB6bKiFQOm80/
	VmYr1FFfgobp7iviI8MTpDwIFSBHk67YWjzz0jYCrsKhbCx9gOJNzmkR5zZL6wR8RaaelBUEE1m
	g2LKywWv2jhd8QGAduonTmQr88L0105JRqpe2pOHuwdbPWlsCLwSr/TAicHWpKh85FwpQvkLLJM
	G/d0H4uzJ3TVE7xpLWj+l+KpWCU0w=
X-Received: by 2002:a17:90a:a81:b0:369:73a:3266 with SMTP id 98e67ed59e1d1-369519e40bbmr10216834a91.10.1779114460408;
        Mon, 18 May 2026 07:27:40 -0700 (PDT)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a09ed1dsm4205256a91.7.2026.05.18.07.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 07:27:39 -0700 (PDT)
Message-ID: <e4fcacb0-ec95-4289-a647-8e85bf432a2a@gmail.com>
Date: Mon, 18 May 2026 22:27:35 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] fstests: add test coverage for cloned filesystem
 ids
To: Christoph Hellwig <hch@infradead.org>, Anand Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-f2fs@vger.kernel.org, amir73il@gmail.com, zlang@redhat.com
References: <cover.1777357320.git.asj@kernel.org>
 <agK8gc2niqpTuHHt@infradead.org>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <agK8gc2niqpTuHHt@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/5/26 13:37, Christoph Hellwig wrote:
> This is missing a real cover letter saying what this series is trying
> to archive.

I should have copied from v1. See below [1]

SCRATCH_DEV_POOL support for non-btrfs was dropped in v2.
Instead, using the newly added helper  _loop_image_create_clone().

[1]
https://lore.kernel.org/fstests/cover.1772095513.git.asj@kernel.org/
-----
This series adds fstests infrastructure and test cases to verify correct
filesystem identity behaviour when a filesystem is cloned (e.g. via
block-level copy), covering inotify, fanotify, f_fsid, libblkid, IMA,
and exportfs file handles.

  - SCRATCH_DEV_POOL support extended to non-Btrfs filesystems
  - _mkfs_scratch_sized_clone() helper to create a cloned filesystem
  - _clone_mount_option() helper to apply per-filesystem clone mount options

New tests verify:
  - inotify and fanotify events are isolated between cloned filesystems
  - f_fsid is unique across cloned filesystem instances
  - libblkid correctly resolves duplicate UUIDs to distinct devices
  - IMA distinct identity for each cloned filesystem
  - exportfs file handles resolve correctly on cloned filesystems
-----

