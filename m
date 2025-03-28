Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC6633991
	for <fstests@vger.kernel.org>; Fri, 28 Mar 2025 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743127405; cv=none; b=L9K2XI/j2QhHANQ7PmuDuykgn6edu3mheR5aNuX0NP7d/+e2IJvmfCB4wIkL3eneCMM9Arzje3rJTy4q8k86L8Awe0mumtB2y2Z3E3WcJycgwNtbqcTAFJfMElk4xmc+JCa0UxQDFC8cG+EzRp+Ny7amh8poN2SErLfQtQjJLao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743127405; c=relaxed/simple;
	bh=+FaoxccULD80hXFy2TIAkbECCTekfpEB10VSbOfabzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haMZ2yZaBkRqByIZrBw35shXiodVnacKP+Zh0ONAyt68wgUXBSY8MDa95wesOT8IC6Qv5o+sYGKy3pxJ7TmenK3qsKif+oL8pXPCtwCn0eYKMa297HpfLLlnuL1P+fLbb4wradJChhsbbDV2ukChL2faCaA/0Yyn1QQD9dIPMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUKN/fnB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUKN/fnB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743127401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBHwFq2gjGhY0d56mKvAIH5z5Nhu5VUsEyCQhwLlONI=;
	b=eUKN/fnBJAh2waaukD+RXz6v8BDan0wpVlteFDyx6osJtHTLkMUJ+c8TQVU5YORCw6ycOg
	HcfI0IMqPQZR6Ci2qNpCWK4x8YHXBPDitV7wQPNGnVjzbYt32NHKmcLLNje7Nb2uVAY3nx
	HMFEHu/fVyDEKpwEYQfnNPhpyPCG840=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-cFpz-dXpOwef4TS2ySMj7Q-1; Thu, 27 Mar 2025 22:03:19 -0400
X-MC-Unique: cFpz-dXpOwef4TS2ySMj7Q-1
X-Mimecast-MFC-AGG-ID: cFpz-dXpOwef4TS2ySMj7Q_1743127398
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-224192ff68bso30214855ad.1
        for <fstests@vger.kernel.org>; Thu, 27 Mar 2025 19:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743127398; x=1743732198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBHwFq2gjGhY0d56mKvAIH5z5Nhu5VUsEyCQhwLlONI=;
        b=bU4E7iYnww69ktqeDm9CyWPoABeGXzfSDifDHPS9IwwwohE9SLRy3pQ9GowBs1t7cv
         mPR2YaRV6lsw6jPjQnYBcs21DlgdApiQjXFi6bsziFB3rT1agclhuTmUihuHp845cTIp
         +fupgfzxkAwANIhUTM+evXu1agHWkMK8B0/ww6+DIADxVtAmUplJiurSxWnqgW1zB+Mc
         +eZuUuvYjbqoUZo+lgBXa6wH5618OvJr95HBUY7k+75UO17QT9Kh3tEAQ1iQp3lhNf20
         3Rgb/5XP5ZtZYByPlp9kL3P1bAWoMWowuV28rdx9GPXvdKazMPXhNZdnB7I46WfctMdJ
         Cu2w==
X-Gm-Message-State: AOJu0Yy08IR8toB6PfmfMgL316ciDpEFKvHgia64wtJ4rOnCS2lLmB1n
	jrWepriSxZ2RN3NKHyixnXqiqK5skpBYD40MzRv8vnK/RaH716mQ0uyI57r2HoNL/bbKfdPgYJK
	hWN/kBTkxL3gXo5AI/ArIdhU9qjKuxQWtA2GEk6dm25AZjwp4ch+GqSQHoQLOJJQ=
X-Gm-Gg: ASbGncuz0aYiOuAzC8gML7Gv5bfeYPzQM8PPMv2XFUasIt3wc0LY5iXrHMjSWBog6ls
	QZDU3dJIjXTRjpYe+yIOT/un4UHP1di+V0qVzzBoj+7rHGR8fRwUGVmGylgDjX3Dzk7JnpO+4hp
	+vgIW5kHtunCXyUcGg7Dio9IW4ZPeqCnlxJftQps9bGFy6S6g599RVYl3romWXYQMVC1gzybZmA
	bUhpZ+r2248l7wHVd7FWlD+hSnLjC9z9OUGmP6+Oluu8MhxfBxsmlW9skGUP91C4quQ/haxYW0W
	4vHB/SSv9jjh9eDDuwqAj+4mI3FXTSJwHuIoqCWwPX7YktTJBA+cMMLg
X-Received: by 2002:a17:903:1a05:b0:224:78e:4ebe with SMTP id d9443c01a7336-228049491f3mr84635225ad.33.1743127397786;
        Thu, 27 Mar 2025 19:03:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7itjdAoNJ8IydE9HEZHRSihBRgsHorYPQLqQWscsLjtT+Hkqfg9IRVoMEh6cayb7D0mUWzg==
X-Received: by 2002:a17:903:1a05:b0:224:78e:4ebe with SMTP id d9443c01a7336-228049491f3mr84634775ad.33.1743127397275;
        Thu, 27 Mar 2025 19:03:17 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf131sm6683365ad.134.2025.03.27.19.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 19:03:16 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:03:12 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250328
Message-ID: <20250328020312.psokbxpz5untmeey@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250328012637.23744-1-anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328012637.23744-1-anand.jain@oracle.com>

On Fri, Mar 28, 2025 at 09:26:24AM +0800, Anand Jain wrote:
> Zorro,
> 
> Please pull this branch, which includes test cases for sysfs syntax
> verification of btrfs read policy and chunk size. v4 has been on the
> mailing list for a month now, along with fix from Filipe and Zoned
> testcase from Johannes.
> 
> Please note that the commit:
>  "fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch"
> 
> has the changes discussed with Naohiro, including his review-by tag,
> (which is missing in your patches-in-queue branch).
> 
> Test case number for above commit is changed to btrfs/335 following
> the integration of the sysfs patches.
> 
> Thank you.
> 
> The following changes since commit d71157da4ef4cfdbf39e2c4a07f8013633e6bcbe:
> 
>   common/rc: explicitly test for engine availability in _require_fio (2025-03-17 00:43:12 +0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/asj/fstests/tree/staged-20250328 
> 
> for you to fetch changes up to 208a7f874df38bf873137d00634783422965a7ab:
> 
>   fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch (2025-03-28 08:25:55 +0800)
> 
> ----------------------------------------------------------------
> Anand Jain (5):
>       fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
>       fstests: filter: helper for sysfs error filtering
>       fstests: common/rc: add sysfs argument verification helpers
>       fstests: btrfs: testcase for sysfs policy syntax verification
>       fstests: btrfs: testcase for sysfs chunk_size attribute validation

Hi Anand, these 5 patches don't have any RVBs or ACKs. Do you miss that?
Although you can ack patches by yourself, but these patches are from you,
maintainers would better not push their own patches directly without any
RVBs. So please let someone review and ack them at first.

> 
> Filipe Manana (1):
>       btrfs/058: fix test to actually have an open tmpfile during the send operation
> 
> Johannes Thumshirn (1):
>       fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch

I'm going to merge these two patches to the release of this week, and give them
regression test at first.

Thanks,
Zorro

> 
>  common/filter       |   9 ++++
>  common/rc           |   3 +-
>  common/sysfs        | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/058     |  28 +++++++++--
>  tests/btrfs/329     |  19 +++++++
>  tests/btrfs/329.out |  19 +++++++
>  tests/btrfs/334     |  19 +++++++
>  tests/btrfs/334.out |  14 ++++++
>  tests/btrfs/335     |  62 +++++++++++++++++++++++
>  tests/btrfs/335.out |   7 +++
>  10 files changed, 317 insertions(+), 5 deletions(-)
>  create mode 100644 common/sysfs
>  create mode 100755 tests/btrfs/329
>  create mode 100644 tests/btrfs/329.out
>  create mode 100755 tests/btrfs/334
>  create mode 100644 tests/btrfs/334.out
>  create mode 100755 tests/btrfs/335
>  create mode 100644 tests/btrfs/335.out
> 

