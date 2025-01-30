Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A31547C9
	for <fstests@vger.kernel.org>; Thu, 30 Jan 2025 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738270217; cv=none; b=EqwLuUBo//9t77S5ELRzSrpyaPI3ScDIXXf3/r5rSerBsHXdh/iM65VLumwg4N0XjLYSYSjCyAaU+shNPHD+yM/oFLKb+jSmzOeuu6jMiPcrgDzf+MxUNT5HLml72N5Q0pyHNd55KnpvIqNYKyl4T54FeUdY4ZHOEq30VZmYVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738270217; c=relaxed/simple;
	bh=2VY/ViKDRyU6YXw9y0djerweNLV8XCRrM+62Sknx4BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDBZRHKIQ1kOCYTUOTqQLaPRxIhNm8G+oVX1zbTdpLpIcA1iM3DCif56XkIcvly4YSjtLZRjdAHXIBz9Ktir/8gz73rdx2pVZFszHCg05dV+DwAL6lVQJ+PE9SYmOweyaSPePA0HUzwY3gbR5HnbVp0nUYlitvtiZz6VbFRE58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=12ItyyZ/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="12ItyyZ/"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21ddb406f32so20020735ad.2
        for <fstests@vger.kernel.org>; Thu, 30 Jan 2025 12:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738270215; x=1738875015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNrCGgEqijIM4yxxbVALPZNjpU5BZk2lZn82e6B/5BU=;
        b=12ItyyZ/oYSea8Sju8WUpHuBtNUdBqNhw7Pz5PYQNXMd303ggBnWIReLMGSRCS+8rp
         /q7A4JTTdNPzn/EBuLotD2IQ8ugNxM6X0sXm4W0u6aNje5C2BRVl80xTxrJAfTYqyYkA
         i2cWgc/GkK7+VVL+vQ0oYG5ezvv45wFKyoFgaFX+JC0EieAqthzqFJW4wvL0sMgwTDKe
         9vn2Xbg62AuX58nybw/gr/HmPmJcoKUVjOpKf6166RfVWGTy3MGZ4asaysNBe7RDLJ7Q
         aBrYoDc8PCXBVExCbrkI72dtTY/YCldXnpnAHH74T2lsTnmer/cp2SnN8w3cF4lIPxUB
         yUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738270215; x=1738875015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNrCGgEqijIM4yxxbVALPZNjpU5BZk2lZn82e6B/5BU=;
        b=fXtss5/okPDTWzri8RErkL6k/wkz3EmzhOrj/bAXIcWaoKNQaXP47X418FoPvseICv
         k2gWUhOpu+LbP4t8sP5bJoh+mYOonRqZ/6P6XOmTN9YLB2xn1EeBNjQ4RmNffIueM5Mu
         keIpd/a7FW0EWfO/0U92MRFN7Q79xsdeg4B49iT76v3zgQpZEJOENSMFPfcKM3oM0Cuv
         DimGhxPtKVi/UTCXHX+Bplpk8jh+0WVVatNSCBJqtL6ZKWm5tLQismGrQHby/Wo8/0mT
         MjmOFkUMvLkEYRzzWKwLI3CC3JF0Q6GeTJoXgYbu4U/PkqUN3KrrjZIB74IoiZ2UDkKa
         SEHQ==
X-Gm-Message-State: AOJu0Yx0cZqwzMDQise/+RXJOWN6bgAq4YipSXO2oJt0LHRtesxEUDmW
	DOGIBIJtkJDkmP7vZeUEGfKFpDrjSSFdBY3tTgFCPSFhoF/7+h2kVipkJXfz3B1+zKUmDek49/Q
	5
X-Gm-Gg: ASbGncsKzxEPtSA1MBR7EGGGrZ75jT/2GMuwPMuVb3NARxAms8goDm+ep6v9F/UlqMK
	/ln+hcf+uV0YzMchfHlLF8qvZyMhTXqxkzi5aQoEZQLpbe7do7tqT35AyTimwRozHYigj+JLqLk
	Yqfpgr1pL9hC9EEAgiQUCfCQaDVKFjfHmmfPsRpcJJggc5MdAH2O3P3Ugz4GXgc+Ua61Bz0zA2P
	g3Iv69if1TFjciSy3bYW8h8/7hMNxAFD1CmFahCTEwmOMmpvkV7ZehJ+rKD74T72KzkvmocUeJL
	umRYXfml8+RHumYKEEF2jLL+V4QuYbQYcAZcE3TrcJgvtpSnwULH0TYCJe4UIpaptvs=
X-Google-Smtp-Source: AGHT+IHlfN1d22f6+db2vxdMJ7Z6v0jZYOuGsJSMpHBga2xHmYbZJRPruJUl67tofc6roF4x92wOjA==
X-Received: by 2002:a17:902:c941:b0:216:25a2:2ebe with SMTP id d9443c01a7336-21dd7c65844mr123458885ad.19.1738270214822;
        Thu, 30 Jan 2025 12:50:14 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31ee1efsm18190795ad.28.2025.01.30.12.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 12:50:14 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tdbUJ-0000000CZ0f-3T99;
	Fri, 31 Jan 2025 07:50:11 +1100
Date: Fri, 31 Jan 2025 07:50:11 +1100
From: Dave Chinner <david@fromorbit.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] fstests: btrfs: testcase for sysfs policy syntax
 verification
Message-ID: <Z5vmAzAEtzK_EuXO@dread.disaster.area>
References: <cover.1738161075.git.anand.jain@oracle.com>
 <3aecf19197d07ff18ed1c0dda9e63fcaa49b69d1.1738161075.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aecf19197d07ff18ed1c0dda9e63fcaa49b69d1.1738161075.git.anand.jain@oracle.com>

On Wed, Jan 29, 2025 at 11:19:54PM +0800, Anand Jain wrote:
> Checks if the sysfs attribute sanitizes arguments and verifies
> input syntax.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/329     | 92 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/329.out |  2 +
>  2 files changed, 94 insertions(+)
>  create mode 100755 tests/btrfs/329
>  create mode 100644 tests/btrfs/329.out
> 
> diff --git a/tests/btrfs/329 b/tests/btrfs/329
> new file mode 100755
> index 000000000000..9f63ab951eac
> --- /dev/null
> +++ b/tests/btrfs/329
> @@ -0,0 +1,92 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 329
> +#
> +# Verify sysfs knob input syntax.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +. ./common/filter
> +
> +# Modify as appropriate.
> +_require_scratch
> +_require_fs_sysfs read_policy
> +
> +_scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +set_sysfs_policy()
> +{
> +	local attr=$1
> +	shift
> +	local policy=$@
> +
> +	_set_fs_sysfs_attr $SCRATCH_DEV $attr ${policy}
> +	_get_fs_sysfs_attr $SCRATCH_DEV $attr | grep -q "[${policy}]"
> +	if [[ $? != 0 ]]; then
> +		echo "Setting sysfs $attr $policy failed"
> +	fi
> +}
> +
> +set_sysfs_policy_must_fail()
> +{
> +	local attr=$1
> +	shift
> +	local policy=$@
> +
> +	_set_fs_sysfs_attr $SCRATCH_DEV $attr ${policy} | _filter_sysfs_error \
> +			| _expect_error_invalid_argument | tee -a $seqres.full

This "catch an exact error or output a different error then use
golden image match failure on secondary error to mark the test as
failed" semantic is .... overly complex.

The output on failure of _filter_sysfs_error will be "Invalid
input". If there's some other failure or it succeeds, the output
will indicate the failure that occurred (i.e. missing line means no
error, different error will output directly by the filter). The
golden image matching will still fail the test.

IOWs, _expect_error_invalid_argument and the output to seqres.full
can go away if the test.out file has a matching error for each
call to set_sysfs_policy_must_fail(). i.e it looks like:

QA output created by 329
Invalid input
Invalid input
Invalid input
Invalid input
Invalid input
Invalid input
.....
Invalid input

-Dave.
-- 
Dave Chinner
david@fromorbit.com
