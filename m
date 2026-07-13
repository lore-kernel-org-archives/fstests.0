Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373DE2745E
	for <fstests@vger.kernel.org>; Mon, 13 Jul 2026 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970470; cv=none; b=R/HeZ0vF0fQ7dfm1OFpQJCHELCewSYddWpHLP6nrhhlk5L4i+sjAk511Zk0VM/WUYFZLzA7HYJNb/2sEdFxCeLHGNPh89PVHLtyCm8PwtzEUqQGq/TLXD8Mb7ixm50imC81YcOBoGq6C37CZ1IDIYpMfLKA/I5PjGtwtHuu1ycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970470; c=relaxed/simple;
	bh=WZhpU3X7z8x2FJfF7PEToOPCaF0MlldEzCysqJtGdw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ev3BxyP0PYyolNlPzw8zFuvjomMDzv2MWTotaXdc4f+15/iGhS6iiOCOIPjPnOed3KTvmhpEO0UqYAgxIBRaUpHz75BIE+n1/+F29v/NxnsjJyRV89IW1vzA4xl+uO0r10J3TytmDDpQMtXpIj+KCDq7XLvG0/0aVtbAgCaxeSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YAXQ01VK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YAXQ01VK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b966dd74so13514745e9.3
        for <fstests@vger.kernel.org>; Mon, 13 Jul 2026 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783970466; x=1784575266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y2AMVnoVjpBYMMCCnhUFWWlqgisv/qZrnv0HDy0uOdc=;
        b=YAXQ01VKmdFcR5J2E7apmxdFsMEB01mOaG53ON1Tv0A3TRxgvjU280EbUtpWWZ4KbU
         BRRnNtrKywf497lLXr1BUSWrqOkf4znrzAId9P0VYA+Xfl8Fh4eC4k45zB+DtPsITc9/
         umVrR2g6RSTMPCWmQO/O5nxYEb+f6fQB80QiyPvpeqEk+uuDt7krVDb12WqCv3bAJrlq
         5MG9HZfIuQ1UWtgWfaEjHaibyQhsKhCF4GoXma+3+wqIMwsSAdA/+jHBZ+ym0hYgaDGQ
         fjojZmNsCKJrNMTyl1UBxPwFUuOuh0z4nx8diMkCE+6L2mu+tdJcGmAZoy5L32IQgr5p
         3SBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970466; x=1784575266;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y2AMVnoVjpBYMMCCnhUFWWlqgisv/qZrnv0HDy0uOdc=;
        b=qbZxz+wysu7amGFb+8eXReHGN9nVXOgMJLHzjveKOb9hi1yxxyOFWhGitw5ocNNufD
         LHn0sjQiAOFUHtV6hCpY78q3HALGTnO0vbgLV1jTcEid5f84AxgzI6DMV8Mb0xipxQm4
         hf5z+ZLCmWYD/m8QaM7oAHPgdaMrZwtlraG/EAjRFpCtRbe9huEz62UXBloozuyzfjt2
         b/Yejc2xsLuvGgXAgwVoJsYU7nw+nDL9j/zid4OSqY0eUSaHFbb8YIf1LlQrGLKpXlp4
         pfhWTgxlcnxRis7e3yFlFCKJ3BjTCPjXjlmjayb767uOsJXtk+KWKSyCwkdb+Nwrfafj
         WXvw==
X-Gm-Message-State: AOJu0Yy+RYjNOEdfDJPRJrT5loGTHO6VTSggyHiMflfoKYYAdMI01X5D
	aHQQhb9NU8oAvOzoBHWUlCwYtB6GZf9k5gz8Uv/LPL8h1fEB1lDS4Io0/9OCh3ed0/8rlboX9KK
	TjwKiw6Q=
X-Gm-Gg: AfdE7cmMh+Xs6eMOFLevazcPW57hCu6MyvDBlplHHHLvlb8i0d4U5i1L/IgpJ/NI88f
	bkBxpz2Uv9WNBTjm0M9DJHPmwulX5PAWl4PQbwFuPZXU+ASL9VCCwWS0rbSl1W7IShpKaTHViKJ
	u1wT8Uk0qdcKugvVAi8s2ekYRjtY4zGlYucSa+fTzkVfejZfeKoJ2jdWp7ErZt9cCPLFen/ZH1+
	1amfbYgwiZ9jwODVsVo8S4B+fETFRUXcaRE8Ny5RhccXzgll1mjddOMO7fW4F7gpyjJnHjYKmQs
	PIoFNGAdD2Q7dnaATLDANQZUztp/Mp+LNKKKvq0rFRdlOVsAOXeNBxg8Qk5BCQjZevgyD5WIJft
	CdmfIOz5AY5YGuNgps4GBweTOaAL8v1kSGvIq7x7a1nlg6mF6XtzD+sodQQJwXb4Scu0cz071qE
	WHKBhu7NPgGeuP/+HohqQTYShsfg88WA==
X-Received: by 2002:a05:600c:4f94:b0:493:b730:8d78 with SMTP id 5b1f17b1804b1-493f882e0e2mr99907955e9.31.1783970466413;
        Mon, 13 Jul 2026 12:21:06 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a973fsm1842241f8f.17.2026.07.13.12.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 12:21:06 -0700 (PDT)
Message-ID: <9b95ab03-34c0-4d2f-b4d7-fdb9c8cbb193@suse.com>
Date: Mon, 13 Jul 2026 21:21:05 +0200
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common: strip attr 2.6.0 --restore safety warnings
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20260710234655.GC15202@frogsfrogsfrogs>
 <20260713135256.340261-1-avinesh.kumar@suse.com>
 <20260713161438.GB7233@frogsfrogsfrogs>
Content-Language: en-US
From: Avinesh Kumar <avinesh.kumar@suse.com>
In-Reply-To: <20260713161438.GB7233@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Darrick,

Thanks for the review.

On 7/13/26 6:14 PM, Darrick J. Wong wrote:
> On Mon, Jul 13, 2026 at 03:52:56PM +0200, Avinesh Kumar wrote:
>> From: Avinesh Kumar <avinesh.kumar@suse.com>
>>
>> attr 2.6.0 (CVE-2026-54371 hardening) makes "setfattr --restore" print a
>> warning to stderr when neither -P nor -h is given, claiming it may
>> traverse or dereference symlinks in the dump's pathnames [0]. This warning
>> leaks into test output and breaks generic/062 and xfs/083 (via
>> _scratch_populate).
>>
>> Add a _setfattr_restore helper that runs "setfattr --restore", filters
>> out just the expected warning line, and preserves any other (unexpected)
>> stderr. Convert the callers in common/populate, common/overlay and
>> generic/062 to use it.
>>
>> [0] https://cgit.git.savannah.nongnu.org/cgit/attr.git/commit/?id=3fb06b9ba314d37035d0877e6de313de754f1ac8
>>
>> Suggested-by: Darrick J. Wong <djwong@kernel.org>
>> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
>> ---
>>   common/overlay    | 2 +-
>>   common/populate   | 4 ++--
>>   common/rc         | 8 ++++++++
>>   tests/generic/062 | 2 +-
>>   4 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/common/overlay b/common/overlay
>> index d32f3219..73841dd7 100644
>> --- a/common/overlay
>> +++ b/common/overlay
>> @@ -494,7 +494,7 @@ _overlay_trusted_to_user()
>>   	local dir=$1
>>   
>>   	for file in `find $dir`; do
>> -		_getfattr --absolute-names -d -m '^trusted.overlay.(redirect|metacopy)$' $file  | sed 's/^trusted/user/' | $SETFATTR_PROG --restore=-
>> +		_getfattr --absolute-names -d -m '^trusted.overlay.(redirect|metacopy)$' $file  | sed 's/^trusted/user/' | _setfattr_restore --restore=-
>>   		for xattr in `_getfattr --absolute-names -d -m '^trusted.overlay.' $file  | tail -n +2 | cut -d= -f1`; do
>>   			$SETFATTR_PROG -x $xattr $file;
>>   		done
>> diff --git a/common/populate b/common/populate
>> index 1c0dd03e..f7fcd0c3 100644
>> --- a/common/populate
>> +++ b/common/populate
>> @@ -151,7 +151,7 @@ __populate_create_attr() {
>>   		echo "# file: ${name}";
>>   		seq --format "user.%08g=\"abcdefgh\"" 0 "${nr}"
>>   		echo
>> -	) | setfattr --restore -
>> +	) | _setfattr_restore --restore=-
>>   
>>   	test -z "${missing}" && return
>>   	seq 1 2 "${nr}" | while read d; do
>> @@ -200,7 +200,7 @@ __populate_xfs_create_btree_attr() {
>>   			seq --format "user.%08g=\"abcdefgh\"" "${nr}" "$((nr + incr + 1))"
>>   			echo "user.v$(printf "%.08d" "$nr")=\"${bigval}\""
>>   			echo
>> -		) | setfattr --restore -
>> +		) | _setfattr_restore --restore=-
>>   	done
>>   
>>   	# ... and in the second loop we delete all the remote attrs to
>> diff --git a/common/rc b/common/rc
>> index 79189e7e..6234a580 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -132,6 +132,14 @@ _test_fsxattr_xflag()
>>   	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
>>   }
>>   
>> +_setfattr_restore()
>> +{
>> +	$SETFATTR_PROG "$@" 2> $tmp.setfattr.$$
> 
> Hrm... I suppose if you're going to allow any arguments to setfattr (and
> not specifically require --restore=) then the helper ought to be called
> _setfattr.
> 
> Other than naming, the changes look ok to me.
I made wrapper to take argument (instead of hardcoding --restore=-) to 
handle the generic/062 case where it restores from a file and also have 
'-h'.
And I kept helper name '_setfattr_restore' as it is still entirely 
restore specific but I leave that up to you. Please let me know if I 
should send revised patch.

> 
> --D
> 
>> +	local ret=$?
>> +	cat $tmp.setfattr.$$ | sed -e '/--restore=.*unsafe.*without/d' 1>&2
>> +	return $ret
>> +}
>> +
>>   # This test requires extsize support on the  filesystem
>>   _require_scratch_extsize()
>>   {
>> diff --git a/tests/generic/062 b/tests/generic/062
>> index 89659040..3ef96da1 100755
>> --- a/tests/generic/062
>> +++ b/tests/generic/062
>> @@ -186,7 +186,7 @@ _create_test_bed
>>   _extend_test_bed
>>   
>>   echo "*** restore everything"
>> -setfattr -h --restore=$tmp.backup1
>> +_setfattr_restore -h --restore=$tmp.backup1 2>&1 | _filter_scratch
>>   _backup $tmp.backup2
>>   
>>   echo "AFTER RESTORE" >>$seqres.full
>> -- 
>> 2.54.0
>>


Regards,
Avinesh
