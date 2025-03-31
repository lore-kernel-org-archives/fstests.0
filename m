Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377D2A1D7
	for <fstests@vger.kernel.org>; Mon, 31 Mar 2025 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743426933; cv=none; b=PkP8OmiFLwYE4cloqC5UEGuoVGj1NG09PmyrLDn+oe8sW/5GNSy2vU8geFEDIVGvjLZ5BPvNqjRb7r+rqO749eFHb3+yXVcRgBBg3DJItQfIeo/QJGXsnav+pG8XAgy0h+g3BpOYUrOOY2A3cjVGQIbdS20iun41tsL68721NpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743426933; c=relaxed/simple;
	bh=KSWjcdg4h5QoHP7C/GCWplToljF2To+s22/BFx4tcvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJH9Kp8zppS1rUqww80kiV9A4B/a+ak682zMV2KqvzvJyLTNHPI1CviD0BpZceBJkuXxG9vDDWC1PiEl0U6uuQvZOOqOg18B/uIS88PcBH3AuFMQT4nmHCugHNssAxrDFAZxi4R8g3QPkpAUBKky1EXkWUOboN20kIcM8RfaN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+E8liG6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+E8liG6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743426930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gf+E1T41Dq18PBLvBV2qCLbFdmC3AI2Uqj5f6N41ons=;
	b=I+E8liG6kXGKzpD41gfCPC80Um7DxX9dPGygGp71L9sBe528/z/7JoGVvBjtEyIwpS9nDs
	OEsCt1iEvN/mx4x8Qo0UtrHIiH1q0aiCZFnBGrtL0/uREUs8+/HPVj5Z6zSeqt3Q4E7OyJ
	p3e0JOkS6YKfwtz9oSH9Q60prBc/iV4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-yrBK_mSZNLKs466KY8am2g-1; Mon, 31 Mar 2025 09:15:28 -0400
X-MC-Unique: yrBK_mSZNLKs466KY8am2g-1
X-Mimecast-MFC-AGG-ID: yrBK_mSZNLKs466KY8am2g_1743426928
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-224347aef79so123297305ad.2
        for <fstests@vger.kernel.org>; Mon, 31 Mar 2025 06:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743426927; x=1744031727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gf+E1T41Dq18PBLvBV2qCLbFdmC3AI2Uqj5f6N41ons=;
        b=pQTx3ZO0u+LHI9QwcH47FyHwHpXcOOeuCwGzHTr9cxmZKM74+m/F76AMz7js2TR+9C
         kxldUfzZqmEXzKuRsvIlBVg/+TePDC2iM2TSqICDqiIjqcGckz34jhg6D1/vtbwcZgew
         se52uZXPmBrPQaYvLUfkR8yTn2WJJpQsXwYHnbT9mgHwwkMy1FZwfiTCsXDlbf7SMLr9
         +D98ZURtILzloeqq78Bsw1pGHzo3FGQGlQmANCP5HO8mj/j56aHX7mIRBj6JRSAh8NLI
         O0turTOo2lbn/3y0SZm5oueAJhNhWej4dAQW84f0g8tL4QiXuRV8uX9cUc7y4QRBtWM0
         4RXQ==
X-Gm-Message-State: AOJu0Yz4h5W0brzLqnWs7GHV5kkYl74j+3ajS6IiptH85YOcq4uLcLic
	xXjUooa2TJoblB9powtYS+A99igh39G7KyMyiS+VL4mq2MQh4jDTWeXaLXtuK4frQhsQTGbDUPa
	QL5VZtIW7+FLNpx5xJgh88EFJWckludlRybZncxg+J/XvT4RIfxGjRwHBzRXb6CwfKA==
X-Gm-Gg: ASbGncu6refuhtQ14FTuDlXxoKdjhs/jBtI99ymFczXr0jOLDNCcvIgwiSAnjxwj8h5
	ErfjJeBZrfdgtYbkEPeiQCQ9oiv5vGI+hh8T8kJS+XVdEysPPhZWs2a8q+FHQ8GGRZIkvXlXaLf
	LujPH86SBA2towmokvtDVGV6x/4DRP6ehA42ntHGP0YV9nvg3gjJBr6xHgmIG2A/kpCZmLTTKjm
	sBajb8RYVgXTyRSCbbkyJJpgB4yjVw/+K9Ro/0DP5U8bK4Fllh3TUKYQ3W/4PTZydYLKyAKR851
	ndwUPA31+WOsJjHG264MEpbaH4Sx1T6N+F3GUUneWG3Aux3zULBV1vMu
X-Received: by 2002:a05:6a00:3cc1:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-7398042a634mr10656970b3a.19.1743426927427;
        Mon, 31 Mar 2025 06:15:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY1oFKQl5vXjRjDpIAWkxF6I4Sg+XHiii6oqAgMjCpAl/v3ccVFaD2n6+GuxApQ/YxmskYvg==
X-Received: by 2002:a05:6a00:3cc1:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-7398042a634mr10656936b3a.19.1743426927003;
        Mon, 31 Mar 2025 06:15:27 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710cbd88sm6826076b3a.157.2025.03.31.06.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:15:26 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:15:23 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 3/5] fstests: common/rc: add sysfs argument
 verification helpers
Message-ID: <20250331131523.gk5mnb3jagdsc5xi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

The subject is "common/rc: ...", but this patch isn't about common/rc.
So feel free to remove the "/rc", or use "/sysfs".

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

I got this warning:
Applying: fstests: common/rc: add sysfs argument verification helpers
.git/rebase-apply/patch:153: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

Other looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> -- 
> 2.47.0
> 
> 

