Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D561F8755
	for <fstests@vger.kernel.org>; Wed,  8 Jul 2026 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481142; cv=none; b=UdmCKi8KM7S7Z7Yp8+FW2Rn1tloxSUiMw694u9Npd1vTPWe1NUpgiXMu1PjWZ35RqswpHgOY7JmY6VyF5I8uywM1EgRIgW58ZvhKsZQd8OgwDtNOYPdMcH7CZdVi9Ws59P2IsdWiZAiV17Aly2a88RUv76FALPsv08QtEmmS9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481142; c=relaxed/simple;
	bh=wTSeqBQsQcs1NnrMmY9ve7/blVhX1SIawF1HPo9UJJw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oQk9t1YYXNSdTWgON0t6Fuk0fmUlRGBfi6/2gRx+7SXiMyU8MQ+3Ev+h/3pfWKc2mWfSrIKyjaxL1iC7yqhzjRSRa0WzmbcloMwTZVZiueBBdb3TwWNETQ0urLuo8PS7ttzj0tEmEUZyBjRPy2uXYWQ61+3sKGmtRW42nkbBATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI7eLc+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI7eLc+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948AD1F000E9;
	Wed,  8 Jul 2026 03:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783481141;
	bh=hS1cvogx7rmILOdwa1cOexvAFCvVtvKKnqus3HvfByw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=BI7eLc+ZrbpuF80zxsU9KNd530lWC/Uv25SPLwojj/9MWVyfmwneOgA37a9oDh0Ot
	 a5pbtzf7XYlrCj2lDc+bvK/YJbSuceDfrBNH6pTgg+pLccaI7OrPoaeZkOKhUqIdFP
	 dEujKCShU5k9bVpWc36WqxSIbxBrKZpri9hXOYr3iG8gV1nRjIn7ex96VyznzEa8aG
	 dkX5hNHOqR3wniPiS0d2eJu2OnJZh2dmNrr6NjmLPYzlQaLv1CDW/71oec7u1g28Az
	 tRVTRAd2lxqZfNF8B695TPef4IKoEKZtblOm9N+Zqrcdq8RprHGPYl3atrumR1jQLS
	 QQIFd52cTw/tg==
Message-ID: <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
Date: Wed, 8 Jul 2026 11:25:37 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] common/rc: support f2fs in
 _require_fanotify_ioerrors()
To: Anand Suveer Jain <asj@kernel.org>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20260706064326.3657995-1-chao@kernel.org>
 <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 18:13, Anand Suveer Jain wrote:
> On 6/7/26 14:43, Chao Yu wrote:
>> f2fs has supported to report fserror, this patch adds support for f2fs
>> in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.
>>
>> Cc: Darrick J. Wong <djwong@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  common/rc | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 494725547..f51ad59f3 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -6257,6 +6257,9 @@ _require_fanotify_ioerrors()
>>  		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
>>  		test -n "$x" && return 0
>>  		;;
> 
> 
>> +	f2fs)
>> +		x="$(cat /sys/fs/f2fs/features/fserror)"
>> +		test -n "$x" && return 0
> 
> Don't we need to check if /sys/fs/f2fs/features/fserror
> is present in the running kernel (there are helpers)

Hi Anand,

You mean _has_fs_sysfs_attr()? however, it forces to check first parameter $dev
w/ block device type:

	if [ ! -b "$dev" -o -z "$attr" ];then
		_fail "Usage: _has_fs_sysfs_attr <mounted_device> <attr>"
	fi


> before reading it?

How about this?

f2fs)
    local feat_file="/sys/fs/f2fs/features/fserror"
    if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
        return 0
    fi
    ;;

> 
> 
> 
>>  	esac
>>  
>>  	_notrun "$FSTYP does not support fanotify ioerrors"
> 

