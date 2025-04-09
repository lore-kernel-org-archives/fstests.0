Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925325D90D
	for <fstests@vger.kernel.org>; Wed,  9 Apr 2025 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194128; cv=none; b=rB8zV/nZsYNbSMsc53ccrTpx7xIMKiIoab4x+6dZljBiBWKp3qzRFqsYb9CzBpslvsr6if2mpFmQZnuRWEqxhhzcj48K6vJpTfrphgI6VqG3Nm1lLMAIJDTrZPL/LbJCXWkg4dEQPw4VRD+S6BstrxgHgjqF5FZqpWd8ETLsZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194128; c=relaxed/simple;
	bh=Z9VexToz3nnp1JDveeL9jqmixKmDtFR4TwslIbZ/nBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5d8ON18auvgQwrXh9cZXUTU4rhVva4/6eLGCB0ksSyvuUQNEvDbe0WZzXdd1aaDKZQ9fRYPMlBdRbgeA/SEM1nTZXr6vbA2Nae0vzO2OuS9WT5YLBbGqYmsvAYXXIRCRQI7Sz2n5SqbBckXC1SLeuduPADdRry6odENHY7Psfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b38jAnl2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b38jAnl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744194126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+m2i/iot7yXQKtdJqxZABg1r8ZEYHkst+29VFgjEFE=;
	b=b38jAnl2TOBsAv693WpeF4Uff7QYJhZp1cqc+OE43sYWHFhP8gUkErQAWxF20tOcMogJSa
	ofR1uA3Wit29vGFnZOH2gmmylHayfQkR0ayzFRr98QqD5XCMPVM66lBpPyj8UlvN6dcj8E
	N00V7/e0xxrQ11XJArSpmyqvosA2XKk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-BWKg7EOcNGG12HuRiaNn9Q-1; Wed, 09 Apr 2025 06:22:04 -0400
X-MC-Unique: BWKg7EOcNGG12HuRiaNn9Q-1
X-Mimecast-MFC-AGG-ID: BWKg7EOcNGG12HuRiaNn9Q_1744194124
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7370e73f690so7798869b3a.3
        for <fstests@vger.kernel.org>; Wed, 09 Apr 2025 03:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744194124; x=1744798924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+m2i/iot7yXQKtdJqxZABg1r8ZEYHkst+29VFgjEFE=;
        b=A/u9Iy6RtDsGM9iYRDg+7VYpthxUnN/Q8GX3/OnPBPSj0w3sLWqiBzYkNYmMtZM+75
         G0cdqRfd19SNkC5GLZOI7b9KkeyRNVKDA8ILwOAdFCr9ehIIQG9Lj71dugSt+hEO6uB9
         q3MlUbc0MC7xegQtLs7tHEAvBELOzIS/6gODx2rUkbMTuCTSWNcRPpwdrLh6s9HprXhX
         XAuHlS93iGUMH1xOrckNH8SI6NrPMChlxOpAWEV+Is4SYpICxlkpS8FFWmtiMxaqXF4+
         6ASUlqPJb6DNw0JXEg75xlKNH2NC39AYgJB+bJunBUprcN4yPEWx6BWi+JyrS9ygVc+A
         /ejw==
X-Gm-Message-State: AOJu0YxHeyrUFUf0na7M3CdpHQogpiOo+TTLp75UfJI6tERSK9K8/uES
	5CAU3kUOowcpqOFYW4iaVe0QN04O0ur+YzhEOkPybOZvOTKlaft/yjSHYm1LMSh6P73ZkIEqR7b
	A/qoc1SUJX3ZU92NI/Z/tCFyTg1gZTbChxQW8jNWnAOZeAtAWl41ynaw=
X-Gm-Gg: ASbGnctCQrEa7UNXWmXGKrBGOHcI/Ee6taFtNKJxqR5Ji64g1htwcBrBpBAiDRcko2Q
	2I51kL46RDQm87+TEoAG4JL1unZum1E3HDwAQpviyNTMECWnarMhW1s0baViRhmFZLBB9zWSilV
	3j7wUWU37C80atamTUWxZiTX9QGA+NyssNAuRPeM5riZGlIEknhGkNtdXzWoWl2FAbgmBjZjqhG
	7kwKw1Y5QDKJF3yC00TVqoP8Qct1RIA+Trq+EaTK5sgij2LTpvyWEccR9eUTWOr1U+UskGOfL5W
	yHMf8y2goTBoOUr2C8NZKFKhTFaHtbCjCt/DAbiJ+Mieso9vHalM
X-Received: by 2002:a05:6a00:22cd:b0:736:a8db:93b8 with SMTP id d2e1a72fcca58-73bae4929eamr3217490b3a.3.1744194123791;
        Wed, 09 Apr 2025 03:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoDfu+ZzZqe3WtTFV94/EyNEg2vjFHg5Cu6poDHKBuYa7KT1JnR1u5MVOwp3qYbch9BoWTeA==
X-Received: by 2002:a05:6a00:22cd:b0:736:a8db:93b8 with SMTP id d2e1a72fcca58-73bae4929eamr3217456b3a.3.1744194123272;
        Wed, 09 Apr 2025 03:22:03 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d487e1sm960380b3a.54.2025.04.09.03.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:22:02 -0700 (PDT)
Date: Wed, 9 Apr 2025 18:21:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v6 4/6] fstests: common/sysfs: add new file sysfs and
 helpers
Message-ID: <20250409102159.567xsmwrjfkqqb4k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
 <10810a81ce8a15a95d3b4653f65ef2b0d57c442b.1744183008.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10810a81ce8a15a95d3b4653f65ef2b0d57c442b.1744183008.git.anand.jain@oracle.com>

On Wed, Apr 09, 2025 at 03:43:16PM +0800, Anand Jain wrote:
> Introduce `verify_sysfs_syntax()` and `_require_fs_sysfs_attr_policy()`
> to verify whether a sysfs attribute rejects invalid input arguments
> during writes.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

This version is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/sysfs | 145 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 common/sysfs
> 
> diff --git a/common/sysfs b/common/sysfs
> new file mode 100644
> index 000000000000..16d4b482f9e9
> --- /dev/null
> +++ b/common/sysfs
> @@ -0,0 +1,145 @@
> +##/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
> +#
> +# Common/sysfs file for the sysfs related helper functions.
> +
> +# Test for the existence of a policy at /sys/fs/$FSTYP/$DEV/$ATTR
> +#
> +# All arguments are necessary, and in this order:
> +#  - dev: device name, e.g. $SCRATCH_DEV
> +#  - attr: path name under /sys/fs/$FSTYP/$dev
> +#  - policy: policy within /sys/fs/$FSTYP/$dev
> +#
> +# Usage example:
> +#   _has_fs_sysfs_attr_policy /dev/mapper/scratch-dev read_policy round-robin
> +_has_fs_sysfs_attr_policy()
> +{
> +	local dev=$1
> +	local attr=$2
> +	local policy=$3
> +
> +	if [ ! -b "$dev" -o -z "$attr" -o -z "$policy" ]; then
> +		_fail \
> +	     "Usage: _has_fs_sysfs_attr_policy <mounted_device> <attr> <policy>"
> +	fi
> +
> +	local dname=$(_fs_sysfs_dname $dev)
> +	if ! test -e /sys/fs/${FSTYP}/${dname}/${attr}; then
> +		return 1
> +	fi
> +
> +	cat /sys/fs/${FSTYP}/${dname}/${attr} | grep -q ${policy}
> +}
> +
> +# Require the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ATTR
> +# and value in it contains $policy
> +# All arguments are necessary, and in this order:
> +#  - dev: device name, e.g. $SCRATCH_DEV
> +#  - attr: path name under /sys/fs/$FSTYP/$dev
> +#  - policy: mentioned in /sys/fs/$FSTYP/$dev/$attr
> +#
> +# Usage example:
> +#   _require_fs_sysfs_attr_policy /dev/mapper/scratch-dev read_policy round-robin
> +_require_fs_sysfs_attr_policy()
> +{
> +	_has_fs_sysfs_attr_policy "$@" && return
> +
> +	local dev=$1
> +	local attr=$2
> +	local policy=$3
> +	local dname=$(_fs_sysfs_dname $dev)
> +
> +	_notrun "This test requires /sys/fs/${FSTYP}/${dname}/${attr} ${policy}"
> +}
> +
> +_set_sysfs_policy()
> +{
> +	local dev=$1
> +	local attr=$2
> +	shift
> +	shift
> +	local policy=$@
> +
> +	_set_fs_sysfs_attr $dev $attr ${policy}
> +
> +	case "$FSTYP" in
> +	btrfs)
> +		_get_fs_sysfs_attr $dev $attr | grep -q "[${policy}]"
> +		if [[ $? != 0 ]]; then
> +			echo "Setting sysfs $attr $policy failed"
> +		fi
> +		;;
> +	*)
> +		_fail \
> +"sysfs syntax verification for '${attr}' '${policy}' for '${FSTYP}' is not implemented"
> +		;;
> +	esac
> +}
> +
> +_set_sysfs_policy_must_fail()
> +{
> +	local dev=$1
> +	local attr=$2
> +	shift
> +	shift
> +	local policy=$@
> +
> +	_set_fs_sysfs_attr $dev $attr ${policy} | _filter_sysfs_error \
> +							   | tee -a $seqres.full
> +}
> +
> +# Verify sysfs attribute rejects invalid input.
> +# Usage syntax:
> +#   _verify_sysfs_syntax <$dev> <$attr> <$policy> [$value]
> +# Examples:
> +#   _verify_sysfs_syntax $TEST_DEV read_policy pid
> +#   _verify_sysfs_syntax $TEST_DEV read_policy round-robin 4k
> +# Note:
> +#  Testcase must include
> +#      . ./common/filter
> +# Prerequisite checks are kept outside this function
> +# to make them clear to the test case, rather than hiding
> +# them deep inside another function.
> +#      _require_fs_sysfs_attr_policy $TEST_DEV $attr $policy
> +_verify_sysfs_syntax()
> +{
> +	local dev=$1
> +	local attr=$2
> +	local policy=$3
> +	local value=$4
> +
> +	# Test policy specified wrongly. Must fail.
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy $policy'"
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy t'"
> +	_set_sysfs_policy_must_fail $dev $attr "' '"
> +	_set_sysfs_policy_must_fail $dev $attr "'${policy} n'"
> +	_set_sysfs_policy_must_fail $dev $attr "'n ${policy}'"
> +	_set_sysfs_policy_must_fail $dev $attr "' ${policy}'"
> +	_set_sysfs_policy_must_fail $dev $attr "' ${policy} '"
> +	_set_sysfs_policy_must_fail $dev $attr "'${policy} '"
> +	_set_sysfs_policy_must_fail $dev $attr _${policy}
> +	_set_sysfs_policy_must_fail $dev $attr ${policy}_
> +	_set_sysfs_policy_must_fail $dev $attr _${policy}_
> +	_set_sysfs_policy_must_fail $dev $attr ${policy}:
> +	# Test policy longer than 32 chars fails stable.
> +	_set_sysfs_policy_must_fail $dev $attr 'jfdkkkkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjffjfjfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
> +
> +	# Test policy specified correctly. Must pass.
> +	_set_sysfs_policy $dev $attr $policy
> +
> +	# If the policy has no value return
> +	if [[ -z $value ]]; then
> +		return
> +	fi
> +
> +	# Test value specified wrongly. Must fail.
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy: $value'"
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy:$value '"
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy:$value typo'"
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy:${value}typo'"
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy :$value'"
> +
> +	# Test policy and value all specified correctly. Must pass.
> +	_set_sysfs_policy $dev $attr $policy:$value
> +}
> -- 
> 2.47.0
> 

