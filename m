Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4613D8A4
	for <fstests@vger.kernel.org>; Mon, 26 May 2025 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242118; cv=none; b=IRcmGL7kMJ/l0HbEq6AwPJuri55w71aNv5LTxwJL0vsuGyU2AjhJdz7w9W51fmZG7qkBMNzxkAhvyUpTIzjnG3yg48BdSh72KOfpyUhCyJAoLyeKlllI+S12R8ZqcOpauunneZDcBdDRuGIJwiK2ZWQH099pVZQ07WE/gr/MM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242118; c=relaxed/simple;
	bh=fpA1Ja41nzKVd6QuLh3RvO0dO/pBQVxGP5MEjPX+WaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BykzokKRxoDbhYn6sTXPN/2BvCiGlqCLcO1LD1sL8VvGF+KyS+CqoTIHtfgInyeqaftMGdVLaQeKqO/HMvA4BkiJme01zy0grhnCJa2XjU9jETa4ZBN3gEnOwbfb0e3qpdb04ufjQnq/bvgVIKO7g7VVh8N3WIoMlNFDcd6L7RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZC2cOrg6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC2cOrg6"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23229fdaff4so20504235ad.1
        for <fstests@vger.kernel.org>; Sun, 25 May 2025 23:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748242116; x=1748846916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvyVEqMaqqFV0V5jW8TPM0VkAqnSa9A78PbwPUjwIvI=;
        b=ZC2cOrg6R6K3vNok96Sci0v7HjjjNWe/7GA/tanBCfo42twQozr0BuDoR/sXmt1W9H
         U+Lp/XU5G9+njqebSc/zeXGDWtCVlFXKODG9fEaFKrQxHroquH+PgN02YmtZXAOCrnL5
         CqU3RlN5rrQwGIPUTBTnpU36g1qbppiSn3KJ7Uo9o6+GtnHOMuMBYwYZA93MR8/RVPon
         B/r4qwCzb6YOUciUx+B0fSe9OtyNscAEHgVrtqrTKXtA8EpZAp9g8oLRS+Vjo0rgvYDv
         lIfTRaO52Q/0L3dD3bL90TAFbDjBbdFtPXN+cZ4axmxCnuoVnI92e5rWiVqvrNjgznpb
         J4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748242116; x=1748846916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvyVEqMaqqFV0V5jW8TPM0VkAqnSa9A78PbwPUjwIvI=;
        b=KdOXht4hWM6tk+3pNr8Fi55VnS5nSYc22VhwpZAwJvNl8krGWKNhxC6KKL/ShysK5Q
         we/vA3t6MJLOC5eR0uBQQVJVM4EpNGyv60LRhd8dQs2lZzLm4gRNScf+rR8E9q2MguIH
         bk41+AqdlLc8lx/N/a8Pgv0uIjux7Tr8F/I2BQKHZudmeG/Fze7B1CQYeyg4MwzU6TC8
         uU1VexOqFChstavCumSS94W5+KVpOr8FiwINeo+ToeRWs+sMbq9kPiwmE4TKIihM3osx
         N5mjizh4xpj8R94h4ykDSw/j5kyuTjbXqNGi3+2CRMUL+S7YcOPsSF/O41go+Aivxo9V
         dTFQ==
X-Gm-Message-State: AOJu0Yz+BbkV8xJtFcxy11/bu2kYxPjBmvFdX4+whGY710MRkVusBIXT
	5JwSjZfAzijLO6rgiMVmmyWKSPs0dE6K6QM6LFXXjvt3pVk8D0Z0sVCa6C9Ehg==
X-Gm-Gg: ASbGnctwgWEaavue918U8YAS8DbPoBDxoZ5VWwCZWjVw321g/dbcJPkahwKFPoZzSDK
	uK66nefQUY9D1mHjmqzKNntvyJtfKj8eCXePAT+T76FdaNRqa7bYhQeZGLIvaUMmkS8p2+xV24s
	ImF8JzWrvEj1QaDmeedye5dyl+prcDRzv8QxaXpHm1qYz6JbjtwLFBnPionH0ZwqyUqQAaM3Mql
	4FJPaNcm0RDgxhPrTouwAvDkALMsIdV0mQ9/m6IWUEILlKEfjWLFQD1TiKZn8Yd3obfXGoiyFjL
	luxQBhPKZQZ9Gb++wQj2Z/8LlfDSjpXhWXJp4FrAuo0NBtAr3E3GUNtF28ATzA==
X-Google-Smtp-Source: AGHT+IENpDB6jP9fwr7AZVRtWa/jITgvmZV+fX0qdGLrwbB3hAqFCohN+3XBNq13U50LaMbQvxw3SQ==
X-Received: by 2002:a17:903:44b:b0:234:4f8e:ed15 with SMTP id d9443c01a7336-2344f8eeec5mr39900035ad.29.1748242115674;
        Sun, 25 May 2025 23:48:35 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23433b21e6csm24071465ad.70.2025.05.25.23.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 23:48:35 -0700 (PDT)
Message-ID: <75181afe-33c7-47cb-8c6b-714fae45ddac@gmail.com>
Date: Mon, 26 May 2025 12:18:32 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/28] check: factor out test list building code
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-6-david@fromorbit.com>
 <3d2f07dc3291ab3e8a391e8909195a339240b16b.camel@gmail.com>
 <aC1Oym2XI_XuThUm@dread.disaster.area>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aC1Oym2XI_XuThUm@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/21/25 09:25, Dave Chinner wrote:
> On Tue, May 06, 2025 at 05:02:54PM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
>>> From: Dave Chinner <dchinner@redhat.com>
>>>
>>> Factor out all the test list parsing and building code to
>>> common/test_list so that it can be used by both check and
>>> check-parallel.
>>>
>>> This also namespaces all the test list code to use _tl_ prefixes,
>>> and adds wrappers to set up test list parsing parameters.
>>>
>>> Note: there is still some future work to convert externally visible
>>> parameters like SRC_DIR to the new namespace.
>> I have gone through this patch. I did some basic testing too with
>> ./check and I havent' found any obvious issues. There are some minor
>> feedback that I have given below:
> Can you trim the stuff you aren't commenting on out? It makes it
> much easier to find what you are commenting on....
Yeah, sorry. I think there was some issue with the editor of my email 
client.
>
> ....
>>> diff --git a/common/test_list b/common/test_list
>>> new file mode 100644
>>> index 000000000..2432be6f7
>>> --- /dev/null
>>> +++ b/common/test_list
>>> @@ -0,0 +1,295 @@
>>> +##/bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0+
>>> +# Copyright (c) 2000-2002,2006 Silicon Graphics, Inc.  All Rights Reserved.
>>> +# Copyright (c) 2024 Red Hat, Inc.  All Rights Reserved.
>>> +#
>>> +# Test list parsing and building functions
>>> +#
>>> +# Note: this file must stand alone and not be dependent on any other includes,
>> We can include common/exit, right? That file doesn't file only has a
>> couple of exit related functions (with no executable code) and no
>> further dependencies, correct?
> I wrote that before common/exit was really a thing.
>
> As it is, I don't think we should be sourcing files from sourced
> files. it hides all the dependencies, and results in the same file
> being sourced multiple times in the same process context.
Yeah, right.
>
> i.e. if the top level is doing:
>
> . common/exit
> .....
> . common/test_list
> .....
>
> Then we don't need to source common/exit from common/test_list
> because it already has been sourced.
>
> That's what the comment is trying to say, and when I wrote it I was
> specifically thinking about the mess that common/rc and
> common/config was causing.
Okay.
>
>
>>> +# most especially common/rc and common/config. This is because we have to
>>> +# include this file before option parsing, whilst the rc/config includes need to
>>> +# be included -after- option parsing.
>>> +#
>>> +# Any function or variable that is public should have a "_tl_" prefix.
>>> +
>>> +export _tl_src_dir="tests"
>> Minor: There was a change[1] which converted some of global variables
>> in small case to upper case. Should we follow the same convention here,
>> i.e, _TL_SRC_DIR or maybe _tl_SRC_DIR?
> I don't think so, I very much dislike the semi-random capitalisation
> of namespace-less variables across fstests. I find coe full of upper
> case variables much more difficult to read and follow than properly
> namespaced lower case variables.
>
> That's the other thing that is important - lots of the global scope
> variables sourced from common files are namespaceless and it makes
> it easy easy for tests to accidentally step on such variables. Once
Yeah, accidental re-use and modification of global variable can happen. 
I agree.
> the varaibles are namespaced, there is no need for capitalisation
> to indicate that it might be a global variable - the namespace
> prefix tells you that as well as where it comes from.
>
>> [1]
>> https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=ab459c67c5e0347ab4a5c28eadfe5ee4e3fd2f01
> Yeah, that was a case of choosing your battles.
>
> It wasn't a bug, but it was buried in a long series of bug fixes and
> at the time people were shouting and being really obnoxious about
> the check-parallel changes. There was no point in dying on an
> unimportant hill by objecting to that change.
>
> I still do think it was the wrong thing to do because it makes that
> code be inconsistent with every other local file loop device
> variable. Those devices are not used outside of common/metadump -
> it is internal implemenation variable that the code was written
> specifically to be hidden from callers wanting to manipulate and
> test metadumps...

Okay, got it.

>
>>> +_SRC_GROUPS="generic"
>>> +_GROUP_LIST=
>>> +_XGROUP_LIST=
>>> +_tl_exact_order=false
>>> +_tl_randomise=false
>>> +_tl_have_test_args=false
>>> +_tl_file="$tmp.test_list"
>>> +_tl_exclude_tests=()
>>> +_tl_tests=
>> Similar comments for all the above lower cased global variables?
> I didn't changed the GROUP names because they are internal to the
> test list implementation. I was largely moving the code and didn't
> want to change anything that was internal that I didn't need to
> touch. I'll have a look at cleaning that up.
Okay.
>
> .....
>>> +	# Specified groups to include
>>> +	# Note that the CLI processing adds a leading space to the first group
>>> +	# parameter, so we have to catch that here checking for "all"
>>> +	if ! $_tl_have_test_args && [ "$_GROUP_LIST" == " all" ]; then
>>> +		# no test numbers, do everything
>>> +		get_all_tests
>>> +	else
>>> +		for group in $_GROUP_LIST; do
>>> +			list=$(get_group_list $group)
>>> +			if [ -z "$list" ]; then
>>> +				echo "Group \"$group\" is empty or not defined?"
>>> +				exit 1
>> _fatal "Group \"$group\" is empty or not defined?" ?
> Remember that this was posted before those changes were made. This is
> the sort of thing that gets fixed on rebase...
Yeah, right.
>
>>> +_tl_setup_exclude_group()
>>> +{
>>> +	local xgroup="$1"
>>> +
>>> +	_XGROUP_LIST="$_XGROUP_LIST ${xgroup//,/ }"
>>> +}
>>> +
>>> +_tl_setup_group()
>>> +{
>>> +	local group="$1"
>> Minor: Since this function is public , do you think it is helpful to
>> have a quick sanitization that makes sure that $1 is not empty and
>> prints message otherwise? Similar comment for
>> _tl_setup_exclude_group().
>>
>>> +
>>> +	_GROUP_LIST="$_GROUP_LIST ${group//,/ }"
>>> +}
> I don't think it needs it. It should be checked by the caller
> if necessary because it is the one doing option parsing to set up
> the group.
Okay.
>
>>> +
>>> +_tl_setup_cli()
>> Nit: This function mostly sets up test list related variables - so
>> maybe a name that suggests that. Maybe something like
>> _tl_setup_test_list_vars or _tl_setup_test_vars - just a suggestion, no
>> hard preferences here.
> Ok, I'll come up with a new name for it, but keep in mind that this
> function is actually parsing arguments that have come directly from
> the CLI.
Yes, I have got that.
>>> +{
>>> +	while [ $# -gt 0 ]; do
>>> +		case "$1" in
>>> +		-*)	echo "Arguments before tests, please!"
>>> +			status=1
>>> +			exit $status
>> use _fatal?
>>> +			;;
>>> +		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
>>> +			local list=$(cd $_tl_src_dir; echo $1)
>>> +			local t
>>> +
>>> +			for t in $list; do
>>> +				t=${t#$_tl_src_dir/}
>>> +				local test_dir=${t%%/*}
>>> +				local test_name=${t##*/}
>>> +				local group_file=$_tl_src_dir/$test_dir/group.list
>>> +
>>> +				if grep -Eq "^$test_name" $group_file; then
>>> +					# in group file ... OK
>>> +					echo $_tl_src_dir/$test_dir/$test_name \
>>> +						>> $_tl_file
>>> +					_tl_have_test_args=true
>>> +				else
>>> +					# oops
>>> +					echo "$t - unknown test, ignored"
>> Minor: Sometimes it has happened with me that I have added a new test
>> (with ./new ) but forgot to run make and hence the test wasn't getting
>> run and was reported to be an invalid test. Should we add a suggestion
>> to run make, in case we encounter an unidentified test name?
> Not in this patch set. If you want these sorts of process reminders,
> please send them as separate feature additions.

Yeah.

--NR

>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

