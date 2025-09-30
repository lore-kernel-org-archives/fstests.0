Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A6B2AE97
	for <fstests@vger.kernel.org>; Tue, 30 Sep 2025 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759204072; cv=none; b=toViLPBpGXzTFA6mPan5dRL5DS3DoWpbG4XDMapvSfdTcAlS18OTx5t+hLg0C2OYmaYWh0yjgz2Hi1FqIOWevCyh8AJmYCivt0GCWkDziFCixtiXlc9SzZL5gOkELU8lsvwS3ES7H9M0YIiLpkpcvqGtMf4PQ8QoHD6ahKVT94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759204072; c=relaxed/simple;
	bh=zsDi7uslgFZ3sSKUmMd091B+OdYeBJygmTOMeEND5oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fB11H5DAwiTLMtPepjRa8PZzT0fD25WgJC1wox8FWLFaa5+MIAqisDOJyUj6emEoZEXJu6v/Cj0bqkqQhwOjWyzO+g9y/sDRQ7P/XFKZTVB8CVUbtyOL2nuswz/NhegDwFRl6lDQA+b0Bv7KoCZvLOUCAR/W9X4+9SxWklK5yvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ7w9lds; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ7w9lds"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4dfbab4fb0dso11313321cf.3
        for <fstests@vger.kernel.org>; Mon, 29 Sep 2025 20:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759204070; x=1759808870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=le1M6VkoM8maBhpGpaBfI2kaslb6T3gdHrKqeP+njDI=;
        b=MJ7w9ldsgY9itc817U9s0ggvgc2HrTlrq8GTF+/Jzx4ljTTpIaBAPlFAM61nPVhnya
         58UtEA5CewRtVuv40sAl0i0mM10UPJetVlZMHipX3+k2RFDmtbyfT3E2IFJvT/TNXS+O
         RaqKCR/1qha9UmiaNgbWE8A2p3RwN8Gimk9x97Y53219SvCOma5JMbIb2hUlqzYH+3Ep
         WXYkbeCrJtS/69mdne7LwiPwS9ALBJ19SIdZ0g6BdD4t3rieOSA6A5JsZCh5/H5UhKU3
         /I8IixrvZd3C0+q+IljmlrvR+V49u+LDFl/AtQdq6NDdDHg2y0CAGlc/m0zxwjC/aWQF
         +7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759204070; x=1759808870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=le1M6VkoM8maBhpGpaBfI2kaslb6T3gdHrKqeP+njDI=;
        b=RcySLewlF7Kn5a3xDRgE4qQvDsb+zxho83iO060FQ5PyPzztS2gWellyIJtmS4RUhB
         T+xlYhqj+G8U8YQSlhm9YbA67QGNdPru4BjrCLNfqReVpnFGN2mR7dcuvGpjrwkrtlK7
         njqkYeUnSYon9AWWVxF8BxfbGBGjwX8EbDwT5iPoI+a8MZifOzrfWmLB6wxDvAZpKX4B
         45GLMUHcFMHpiKtwHK9zhGTno82OBMQbj0azf3YSifwUD9CBANNcWJnlJ0Lcw3QYvHkM
         ZmCagMmxOQ3YDcwbP3YGYmXfmAMg20g+L56wkPbUdFtF3DKFi6UfbIKaHo8FTj/T3lFJ
         fVbQ==
X-Gm-Message-State: AOJu0YyDNQfEMlij8PJGtJ806yBywJfe5LwWv33gMYBVf4wG4HCB+ikT
	i8Lykhu+BbM61/HJiu5xh/dcoZXroR8DN/AdD6n3BqXf9MmEUTvzEX0EZpldKIUq07mTxd+9tyW
	wqr2mK7t0NbOrBRERxYN92+TqCfwnqBI=
X-Gm-Gg: ASbGncthyhqocwRdQfZzDp0VxxheWVAUZfkcenrzxDh4JJJ00MAs8MW/vPENEIZ/5nQ
	q8nb0+/I4phR+pJIb+TglQK4SAGKSWqg+IzFsZR6b07vcKX0iQgsP5AB5hRQyu5KWQ1a9ZjZTu8
	Vfv/vnFCRvEBavLOY8Wnw49hMrzNnU+dthhCqGnXhu9bdyTAk+UAhDeKAglzJdomoYnPtY8g5wb
	mDqOCmbvHbDgJknkpYu8sqqvLsH9Q9aULWFE8CYU1XF0yJ1SQ8MlHbEbvi72A==
X-Google-Smtp-Source: AGHT+IHRn7wwofmckgetIFv7NrcubZxn6rGcrfJ0dYm+EeA9hAKHUc/yMdNYvRtWsOi0Pb8wklD9ICZ4GeMk/aZyVl8=
X-Received: by 2002:a05:622a:5144:b0:4df:fb58:b253 with SMTP id
 d75a77b69052e-4dffb58b653mr90163061cf.48.1759204069824; Mon, 29 Sep 2025
 20:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758148804.git.anand.jain@oracle.com> <512a6148be0d8da51278f94a29b959f3950bcc0b.1758148804.git.anand.jain@oracle.com>
 <20250926155753.yhhrbfnilvmk2t47@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250926155753.yhhrbfnilvmk2t47@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Anand Jain <anajain.sg@gmail.com>
Date: Tue, 30 Sep 2025 11:47:38 +0800
X-Gm-Features: AS18NWCZGtNkWjyUPnubP-JR7Jk5LnsHQ5z55GYM6FNGTIys3gcBfYurna24xq8
Message-ID: <CANZP331iHxPpL0kQfwhzQrSkevs9KS8NF9cvcc-KNDUexM7wbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] common/rc: helper functions to handle block devices
 via sysfs
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 26/9/25 23:57, Zorro Lang wrote:
> On Thu, Sep 18, 2025 at 08:32:46AM +0800, Anand Jain wrote:
>> From: Anand Jain <anand.jain@oracle.com>
>>
>> _bdev_handle(dev)
>>      get sysfs handle for a given block device.
>>
>> _has_bdev_sysfs_delete(dev_path)
>>      Checks if the block device supports sysfs-based delete.
>>
>> _require_scratch_bdev_delete()
>>      Test if the scratch device does not support sysfs delete.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   common/rc | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 81587dad500c..627ddcc02fb8 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -4388,6 +4388,32 @@ _get_file_extent_sector()
>>      echo "$result"
>>   }
>>
>> +_bdev_handle()
>> +{
>> +    local device=3D$(echo $1 | rev | cut -d"/" -f1 | rev)
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> basename $1 ?
>
> if you hope to make sure it's not link, you can
>

> basename $(_real_dev $1)

Whoops, not sure what I was thinking. There's actually a helper for
this, _short_dev().
The changes below will fix it. I can send v2 if needed, unless it can
be fixed at merge
time. Let me know what works best.
-----------------------------------
$ git diff
diff --git a/common/rc b/common/rc
index 627ddcc02fb8..085fab6e34f0 100644
--- a/common/rc
+++ b/common/rc
@@ -4390,7 +4390,7 @@ _get_file_extent_sector()

 _bdev_handle()
 {
-       local device=3D$(echo $1 | rev | cut -d"/" -f1 | rev)
+       local device=3D$(_short_dev $1)

        test -e /sys/class/block/${device}/device/scsi_disk/ || \
                        _notrun "Failed to obtain sys block handle"
@@ -4401,7 +4401,7 @@ _bdev_handle()
 _has_bdev_sysfs_delete()
 {
        local dev_path=3D$1
-       local device=3D$(echo $dev_path | rev | cut -d"/" -f1 | rev)
+       local device=3D$(_short_dev $1)
        local delete_path=3D/sys/class/block/${device}/device/delete

        test -e $delete_path
---------------------------------------------


>> +
>> +    test -e /sys/class/block/${device}/device/scsi_disk/ || \
>> +                    _notrun "Failed to obtain sys block handle"
>> +
>> +    ls /sys/class/block/${device}/device/scsi_disk/
>> +}
>> +
>> +_has_bdev_sysfs_delete()
>> +{
>> +    local dev_path=3D$1
>> +    local device=3D$(echo $dev_path | rev | cut -d"/" -f1 | rev)
>> +    local delete_path=3D/sys/class/block/${device}/device/delete
>> +
>> +    test -e $delete_path
>> +}
>> +
>> +_require_scratch_bdev_delete()
>> +{
>
> I'm wondering if it's better to call "_require_block_device" at first, be=
fore
> checking the /sys ?

There=E2=80=99s no harm in using _require_block_device() here, but I don=E2=
=80=99t
think it will help,
a non block device won't reach this place anyway.
config: _check_device() will fail for non-block devices.

Thanks, Anand

>> +    if ! _has_bdev_sysfs_delete $SCRATCH_DEV; then
>> +            _notrun "require scratch device sys delete support"
>> +    fi
>> +}
>> +
>>   # arg 1 is dev to remove and is output of the below eg.
>>   # ls -l /sys/class/block/sdd | rev | cut -d "/" -f 3 | rev
>>   _devmgt_remove()
>> --
>> 2.51.0
>>
>>
>
