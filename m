Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABDA145355
	for <fstests@vger.kernel.org>; Fri, 23 Feb 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717924; cv=none; b=UXos8EcgsRH5cv68nf02YBGnUjwSzjtwNtgWn1nrByt2bA2iWMlg1YScLpjfiyJJsLAQoMtheTed7OIpWzyh5zLCwxLJ5SK9es6xom9seAvJBpnSvx0i+x3A1TSlyi4C/zchMgF41vySgrKM1MTbcoezzlYAiiaVRwzrie4O010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717924; c=relaxed/simple;
	bh=94QJ6LBVznXgJ4y2QVv4FEdX0JDL4MitiMYyGI9w1Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqT8x4G4wMJcaGokMFT4H2UfW9ddd23Urn/eqv0q0iy98L+HYkrxkzqy0nN3HACIxGcUuFdMZ5KiCJ24ZhIEqVrRQfdC52fSquJikgaSUfIitWZqRS6BvJxQwI0w+htVfkWHlA9obiFDUOH9qe3TCslwkFU5Z1GThAgzXhMngWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ND0a8+M+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ND0a8+M+"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d26da3e15so517037f8f.1
        for <fstests@vger.kernel.org>; Fri, 23 Feb 2024 11:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708717910; x=1709322710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLginQxs9r/9eogisZNYb8ps/GSWg3z8kHfPeP6/tNM=;
        b=ND0a8+M+1zmuHkIdViVaNbHkxcYcNNIotQMu8LQncnPy0DBMISx6kfRg+6TwtV3N3l
         DsQCgA9OxvsrEDakcaWKHceaCZA7LjE4aKq2QvRgJjF09O/NCtAnUF5KIrtpIiX8JNOP
         vpHXPRiAWpDXLoiKoivkwKAqM4mwqk56/LDPxW3/l0QgZteJsBC1PIqFxA3N27L6tAZF
         2RfJjEUziHVn/6ex6ysmeDto2c8cx/E+4x9E/U/GilBtq5MBSAcK/pTho0OhmUdoErUU
         VFbP5vRuAOtHX60cfNNf3ks+M2qeXxeYQH310wmg05cczr/jQrNNCj8lyTTCmVImIFDF
         iAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708717910; x=1709322710;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLginQxs9r/9eogisZNYb8ps/GSWg3z8kHfPeP6/tNM=;
        b=QR80D4TcFe7/duK+xqwudKdg7uoMdo7Z+LiRcZXuHtM4sSnRq79AtE+lZj0p3rzfBl
         g6ba7KaWYHirELuydOT8JKp6JILolZlN3y3jHMiGU8GyjGwcKeJNrBXQZGTehDwWgh8d
         qsTiX80A3Dv8AmwIL4ItRBf4Tl/HrI8clx62ntqxnvrSXYz1EXJlviBFegptGd2BKYcW
         bVzCRMci/ynVUBjY3fU+IrfvMaKyztgvrgjNmQE4BMeJQHLL3vpi5shJml/cfosgf4Br
         8t+xyRi+Ci6GYuAK8zp01+ERcXgtAz6BeNGTmDQbU1G3SZudR+PjTmnClnmraMu9TvV4
         MW/w==
X-Forwarded-Encrypted: i=1; AJvYcCXfpL21iWp6785V074dvQQcNGav4Nkhon5qNfPzs/WJdZkghr1Y6dStbcMPJ5T0rRS6SrmIEg06n5sDZOhjWl1KnyRUyUZ0fQ==
X-Gm-Message-State: AOJu0Yxh33CRV6rumoRJsQSeJHN2l6PB67pScd4fj95vEr5px1cWz6BR
	+zfCoN3OstS4CY/UlzDJj8XJHy/N0pgNdsvAFtSAFKmtSeZgwILMvBkz0X6y5qc=
X-Google-Smtp-Source: AGHT+IFLUUZH/tDYxRP0lRh2BVwKTrvhW86yLHRcwl1Zk+71id+JrMZ0R4UhqoLFJC0Gt05ky3fJbA==
X-Received: by 2002:adf:f6c7:0:b0:33d:61c7:9b2c with SMTP id y7-20020adff6c7000000b0033d61c79b2cmr720334wrp.34.1708717910012;
        Fri, 23 Feb 2024 11:51:50 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id fh14-20020a056a00390e00b006e0737f2bafsm13224640pfb.45.2024.02.23.11.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 11:51:49 -0800 (PST)
Message-ID: <ded4aab0-1bf7-43d2-8a19-12197fe19f88@suse.com>
Date: Sat, 24 Feb 2024 06:21:44 +1030
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: add a test case to make sure
 inconsitent qgroup won't leak reserved data space
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
References: <20240223093547.150915-1-wqu@suse.com>
 <12c20a26-5632-4c53-a011-7e74a781724b@oracle.com>
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <12c20a26-5632-4c53-a011-7e74a781724b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/24 03:37, Anand Jain 写道:
> On 2/23/24 15:05, Qu Wenruo wrote:
>> There is a kernel regression caused by commit e15e9f43c7ca ("btrfs:
>> introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup
>> accounting"), where if qgroup is inconsistent (not that hard to trigger)
>> btrfs would leak its qgroup data reserved space, and cause a warning at
>> unmount time.
>>
>> The test case would verify the behavior by:
>>
>> - Enable qgroup first
>>
>> - Intentionally mark qgroup inconsistent
>>    This is done by taking a snapshot and assign it to a higher level
>>    qgroup, meanwhile the source has no higher level qgroup.
>>
>> - Trigger a large enough write to cause qgroup data space leak
>>
>> - Unmount and check the dmesg for the qgroup rsv leak warning
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> looks good.
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks for the review.

> 
> 
> Queued for the upcoming pull request.

So for the btrfs fstests part, you'll do the pull request to upstream 
fstests, right?

In that case, if we have some conflicting test case number, how do we 
resolve it?

It would be resolved by you or the author would be notified and need a 
resend?

And do we have a branch to base our new test cases upon? (Mostly to 
avoid the number conflicting)

Thanks,
Qu

> 
> Thanks, Anand
> 
>> ---
>>   tests/btrfs/303     | 59 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/303.out |  2 ++
>>   2 files changed, 61 insertions(+)
>>   create mode 100755 tests/btrfs/303
>>   create mode 100644 tests/btrfs/303.out
>> ---
>> Changelog:
>> v2:
>> - Fix various spelling errors
>>
>> - Remove a copied _fixed_by_kernel_commit line
>>    Which was used to align the number of 'x', but forgot to remove
>>
>> diff --git a/tests/btrfs/303 b/tests/btrfs/303
>> new file mode 100755
>> index 00000000..9f7605ab
>> --- /dev/null
>> +++ b/tests/btrfs/303
>> @@ -0,0 +1,59 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 303
>> +#
>> +# Make sure btrfs qgroup won't leak its reserved data space if qgroup is
>> +# marked inconsistent.
>> +#
>> +# This exercises a regression introduced in v6.1 kernel by the 
>> following commit:
>> +#
>> +# e15e9f43c7ca ("btrfs: introduce 
>> BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting")
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick qgroup
>> +
>> +_supported_fs btrfs
>> +_require_scratch
>> +
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +    "btrfs: qgroup: always free reserved space for extent records"
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount
>> +
>> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
>> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
>> +
>> +$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT >> $seqres.full
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv1 >> $seqres.full
>> +
>> +# This would mark qgroup inconsistent, as the snapshot belongs to a 
>> different
>> +# higher level qgroup, we have to do full rescan on both source and 
>> snapshot.
>> +# This can be very slow for large subvolumes, so btrfs only marks qgroup
>> +# inconsistent and let users to determine when to do a full rescan
>> +$BTRFS_UTIL_PROG subvolume snapshot -i 1/0 $SCRATCH_MNT/subv1 
>> $SCRATCH_MNT/snap1 >> $seqres.full
>> +
>> +# This write would lead to a qgroup extent record holding the 
>> reserved 128K.
>> +# And for unpatched kernels, the reserved space would not be freed 
>> properly
>> +# due to qgroup is inconsistent.
>> +_pwrite_byte 0xcd 0 128K $SCRATCH_MNT/foobar >> $seqres.full
>> +
>> +# The qgroup leak detection is only triggered at unmount time.
>> +_scratch_unmount
>> +
>> +# Check the dmesg warning for data rsv leak.
>> +#
>> +# If CONFIG_BTRFS_DEBUG is enabled, we would have a kernel warning with
>> +# backtrace, but for release builds, it's just a warning line.
>> +# So here we manually check the warning message.
>> +if _dmesg_since_test_start | grep -q "leak"; then
>> +    _fail "qgroup data reserved space leaked"
>> +fi
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
>> new file mode 100644
>> index 00000000..d48808e6
>> --- /dev/null
>> +++ b/tests/btrfs/303.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 303
>> +Silence is golden
> 
