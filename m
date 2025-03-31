Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B65212FBF
	for <fstests@vger.kernel.org>; Mon, 31 Mar 2025 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429499; cv=none; b=MZxUTjZnpC6HAg7wantvfz6HzJaS5OZeyzRSURx7gmOiT9jYngWvhndvuhEMNDHsDosfGL89NXDgBHltKwlGStoVQ+McaV2eUv1v7vv4TQIDsae/5Qok+3OypTa8YhBu1sovZA2rYy/O6sKb3CeG8kTM5qTmfuD64zMLC5+0ujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429499; c=relaxed/simple;
	bh=+rOuPaFObrtDvL9HVo8feMX3GcclwEbP2gjnrZ7qXhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USp7+5Va1RJV/2F9X5JwrLUG6G7qpJ3bFtEaYhonsLXHiigoMWV8+05XqIhNB6xxFuZa6wC3b8OqykqGSvLSSyhY651UgJ7Sne+N8XmN46+BwjqmtWFW+FP6jbfaJkUXu0dxvNCsS0i4mnmeD8syort2MG175JrE+QQXEMdOnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iv+PRCW2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iv+PRCW2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743429494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oE1TLdj9H6ruj8gi6AXVEgu+xed4rdbeVMi1cdaqlo=;
	b=Iv+PRCW2qjLmU04Bv0ni9hpabN+1vxw/0wkVcOYBtOEpXWVysvFUKdun3h00IU5mgpvz4T
	8I4ueFiYwlt3yZ9T44iO637RHPTjLP0EH033eOQBAnzuf1sg/dtbBcVB7td13LvofZFZlF
	x9OmPWtk8KUDvurGW3f5c3t7ygf8PZI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-m2V4KpnqOL6lMn3lZVdiiQ-1; Mon, 31 Mar 2025 09:58:11 -0400
X-MC-Unique: m2V4KpnqOL6lMn3lZVdiiQ-1
X-Mimecast-MFC-AGG-ID: m2V4KpnqOL6lMn3lZVdiiQ_1743429490
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso11403622a91.2
        for <fstests@vger.kernel.org>; Mon, 31 Mar 2025 06:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743429490; x=1744034290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oE1TLdj9H6ruj8gi6AXVEgu+xed4rdbeVMi1cdaqlo=;
        b=sAwH0XtybRBzqekrNv9aoVMBj27JfkDf9HbjIjZo2rguPEql7y5lO0tm+Sl5ldRula
         m96+bjlI/qomPhoFHTCAP2vidA3M9BDjX39oCLfi1Q9UqZY54y5LAZ6D4tdCeSc+P1nS
         VVQ20fxwROMCMKBq8n6jsj1URNJY7E0JvLFtw9GMvCHwnf7bZX42XF8BO5OcYZcEAkT2
         rOtWOGaaMfjG/ZkhDfoeUHo4FlqpIhvb7PsgoCbFrwYVZ5Nm39RVWIQbKJTic8O0N8xn
         0oYvpURdTzla5NuiT9QhaQUzVcH32D9MElHxIlNw9EBjOfg/0+6IYpQ3mx0hcjZMnka8
         r1ZA==
X-Gm-Message-State: AOJu0Yyog/OPgANYMshxcf+oSn0qHNAoKS8OuJ3EmPmvXQPm5lllajhK
	Hw/eNfEt/cyDwImYiydBAZYu+2P2lxVwQnHeP0lfcI6Of2HrMrPlMHFM8Q5cOmjkkoG0gjNmprI
	cUL8/5nOkNmkjYqH9TvDrQyzFLd91iZU7mjfHI/QMtoP0yXKJICXiBNg=
X-Gm-Gg: ASbGncunbOxMLTaPDUwISLFPzicH+W4oERnvSPhiLbcVNNlM1iXNmbozKrTzafdaTrS
	wCaAvrBaM+GYyqQlfi+s15FSe4Z7KDOJe0f9vqeQj7FD0Nn8aqsXSgzUHEOzavMcCTh/OL0N4xw
	nq5PkHeFeHy5mCUW1vKCoDvVFD7r+KGSZnOIYXrgqIoiQwt8iLoaKvyZzV/q/G/4ZZDkTfAwj6H
	nUelTEfPNqTeIRC0mLtjgce19ey6b+iFmqw2Rkhg6ag8cZ+3KOT+gdPmbQOEoVSRHRDtzORC7XQ
	APqEqvZ3h80OB/M7I0vVYF5OUg/E/S9KWu4hjUtzxA0HZV8NzRhDgiTW
X-Received: by 2002:a05:6a20:d704:b0:1fa:9819:c0a5 with SMTP id adf61e73a8af0-2009f5fe919mr15452741637.11.1743429490105;
        Mon, 31 Mar 2025 06:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLJn+w/48xdvA1YFN4RLDTbtq9vdfPtO0aFMbqwk5He6AQGi8updCsACvWlqw8GifWy5XI0g==
X-Received: by 2002:a05:6a20:d704:b0:1fa:9819:c0a5 with SMTP id adf61e73a8af0-2009f5fe919mr15452704637.11.1743429489778;
        Mon, 31 Mar 2025 06:58:09 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b6a1719sm6367321a12.32.2025.03.31.06.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:58:09 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:58:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	david@fromorbit.com, djwong@kernel.org
Subject: Re: [PATCH v4 3/5] fstests: common/rc: add sysfs argument
 verification helpers
Message-ID: <20250331135805.knlyocgvo7lyahux@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
 <4c40bdaf996d9b04c2bd8423815d52d930ee32a2.1740721626.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c40bdaf996d9b04c2bd8423815d52d930ee32a2.1740721626.git.anand.jain@oracle.com>

On Fri, Feb 28, 2025 at 01:55:21PM +0800, Anand Jain wrote:
> Introduce `verify_sysfs_syntax()` and `_require_fs_sysfs_attr_policy()` to verify
> whether a sysfs attribute rejects invalid input arguments during writes.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/sysfs | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 common/sysfs
> 
> diff --git a/common/sysfs b/common/sysfs
> new file mode 100644
> index 000000000000..1362a1261dfc
> --- /dev/null
> +++ b/common/sysfs
> @@ -0,0 +1,142 @@
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
> +	test -e /sys/fs/${FSTYP}/${dname}/${attr}
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
> +set_sysfs_policy()
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
> +set_sysfs_policy_must_fail()
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
> +#   verify_sysfs_syntax <$dev> <$attr> <$policy> [$value]
> +# Examples:
> +#   verify_sysfs_syntax $TEST_DEV read_policy pid
> +#   verify_sysfs_syntax $TEST_DEV read_policy round-robin 4k
> +# Note:
> +#  Process must call . ./common/filter
> +verify_sysfs_syntax()

Wait a moment, we generally has "_" for common helpers (is there any exception you
can find in common/ ?).

So better to add rename this function as _verify_sysfs_syntax.

Same to above two functions, please rename them to:
_set_sysfs_policy, _set_sysfs_policy_must_fail,

> +{
> +	local dev=$1
> +	local attr=$2
> +	local policy=$3
> +	local value=$4
> +
> +	# Do this in the test case so that we know its prerequisites.
> +	# '_require_fs_sysfs_attr_policy $TEST_DEV $attr $policy'
> +
> +	# Test policy specified wrongly. Must fail.
> +	set_sysfs_policy_must_fail $dev $attr "'$policy $policy'"
> +	set_sysfs_policy_must_fail $dev $attr "'$policy t'"
> +	set_sysfs_policy_must_fail $dev $attr "' '"
> +	set_sysfs_policy_must_fail $dev $attr "'${policy} n'"
> +	set_sysfs_policy_must_fail $dev $attr "'n ${policy}'"
> +	set_sysfs_policy_must_fail $dev $attr "' ${policy}'"
> +	set_sysfs_policy_must_fail $dev $attr "' ${policy} '"
> +	set_sysfs_policy_must_fail $dev $attr "'${policy} '"
> +	set_sysfs_policy_must_fail $dev $attr _${policy}
> +	set_sysfs_policy_must_fail $dev $attr ${policy}_
> +	set_sysfs_policy_must_fail $dev $attr _${policy}_
> +	set_sysfs_policy_must_fail $dev $attr ${policy}:
> +	# Test policy longer than 32 chars fails stable.
> +	set_sysfs_policy_must_fail $dev $attr 'jfdkkkkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjffjfjfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
> +
> +	# Test policy specified correctly. Must pass.
> +	set_sysfs_policy $dev $attr $policy
> +
> +	# If the policy has no value return
> +	if [[ -z $value ]]; then
> +		return
> +	fi
> +
> +	# Test value specified wrongly. Must fail.
> +	set_sysfs_policy_must_fail $dev $attr "'$policy: $value'"
> +	set_sysfs_policy_must_fail $dev $attr "'$policy:$value '"
> +	set_sysfs_policy_must_fail $dev $attr "'$policy:$value typo'"
> +	set_sysfs_policy_must_fail $dev $attr "'$policy:${value}typo'"
> +	set_sysfs_policy_must_fail $dev $attr "'$policy :$value'"
> +
> +	# Test policy and value all specified correctly. Must pass.
> +	set_sysfs_policy $dev $attr $policy:$value
> +}
> +
> -- 
> 2.47.0
> 
> 

