Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC62CC001B2
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Dec 2022 03:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLKD3w (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 10 Dec 2022 22:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLKD3v (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 10 Dec 2022 22:29:51 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089DB12749
        for <fstests@vger.kernel.org>; Sat, 10 Dec 2022 19:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1670729388; i=@fujitsu.com;
        bh=r1PQ3D97+ipyS4MvyB1QlPtK3nn1HUB7njmnIf6WQus=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=SQHwZ6uPItErUBzNIdN+u5WFVdtNwKHZu84Vu6PQfBkZS2ZX0SySpiRsIyMz8LHPN
         IDsO7pOSwGUXQAt1kqBxsp0hDdRyQ87J3SOT1E7NXT44X+v7+CaeNvCYA2iJFhFTyp
         hIN3eVRBV2cxUzWtjIfPd8gogUPuBisdESk6Qnob40xtx1guzpik8TQnNswF9qefKQ
         a1TJV5WucsYXOw8kwvq6MQpWw0Nkdj3/6MuyrgUkdRZPm3NaehVW4nm8R/lkdaTO8/
         S6ni2GLzx3ZontZwIXFyKYcyBOYoGjLjxyuu943mltxhgIW1izHGLnYQdUNDmHH7sd
         V+dUIIXzB+Xuw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRWlGSWpSXmKPExsViZ8OxWXeV39R
  kgxO92hanW/ayW+w9uZPVgcnj/b6rbB6fN8kFMEWxZuYl5VcksGbM+dzBWLCZu2LpvV7WBsap
  nF2MnBxCAhsYJZY8iehi5AKyFzNJvLo+nRnC2cIosfHGe2aQKl4BO4mHUxrYQWwWAVWJX9ufQ
  MUFJU7OfMICYosKJEv09c9k62Lk4BAW8JT43WIDEhYRUJRY8/MiWDmzgKxEY+sWVojFpRKHp/
  wFa2UT0JG4sOAvWJxTwEbi4q7b7BD1FhKL3xyEsuUlmrfOBpsjIaAgcWPSKhYIu0Ji1qw2Jgh
  bTeLquU3MExiFZiG5bhaSUbOQjFrAyLyK0bw4tagstUjX0EwvqSgzPaMkNzEzRy+xSjdRL7VU
  Ny+/qCRD11AvsbxYL7W4WK+4Mjc5J0UvL7VkEyMw/FOKU5l3MF5e9kfvEKMkB5OSKO+x6MnJQ
  nxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4JXynJgsJFqWmp1akZeYAYxEmLcHBoyTC2+EKlOYtLk
  jMLc5Mh0idYtTlWNtwYC+zEEtefl6qlDjvPx+gIgGQoozSPLgRsLRwiVFWSpiXkYGBQYinILU
  oN7MEVf4VozgHo5Iw736QKTyZeSVwm14BHcEEdMTKLxNBjihJREhJNTBN2BvI/29y4J3AzxF5
  87eypX8vfsDzrfi9Ctulz15m37f5rDpeVaQXvN/+yWYWjsbKF5pVxyYVZPGdr7y5/QHX1bule
  XKXY54qsBfnM8/dwXrTWtGx/8vn9F67KdNjFKN8T/ZKS/NUc7xUmto1KcBizrOcGSbr9KzExZ
  emHLRfczp850Rl60JlvljLzXL3Hp4RXGHizf9IVY/d40GbkMdjxgyVtqUThJgOxraJKP5eZPV
  5S98PgQzhtefiCkLaJ3JofX756kP1RWvX4OwbGqs5Lh478oZJTmaNkWV4Z6THqeJrLyqXe19o
  6FVakLfz0NblnlFXWg9nvbjiEtoRdmZa9szAeyFbJD65RuxztVdiKc5INNRiLipOBAC4g9xch
  gMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-21.tower-728.messagelabs.com!1670729386!138314!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27185 invoked from network); 11 Dec 2022 03:29:46 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-21.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Dec 2022 03:29:46 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 28FDC7B;
        Sun, 11 Dec 2022 03:29:46 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 1C5C273;
        Sun, 11 Dec 2022 03:29:46 +0000 (GMT)
Received: from [10.167.201.2] (10.167.201.2) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Sun, 11 Dec 2022 03:29:43 +0000
Message-ID: <b18a0b99-3895-b234-4b0c-4ee8c8e6e44e@fujitsu.com>
Date:   Sun, 11 Dec 2022 11:29:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] add files to ignore & chmod 755 tests/generic/692
To:     Zorro Lang <zlang@redhat.com>
CC:     <fstests@vger.kernel.org>
References: <1670639465-53-1-git-send-email-ruansy.fnst@fujitsu.com>
 <20221210141121.ehlec7dnpwchynbe@zlang-mailbox>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20221210141121.ehlec7dnpwchynbe@zlang-mailbox>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.201.2]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2022/12/10 22:11, Zorro Lang 写道:
> On Sat, Dec 10, 2022 at 02:31:05AM +0000, Shiyang Ruan wrote:
>> 1. The executable binary in src/ should be in ignore file.
>> 2. tests/xfs/216.out is a symlink generated at runtime, also should be
>>     ignored.
>> 3. tests/generic/692 was created with 644.  It should be 755 otherwise
>>     its mode will be changed and dirty the git tree after test.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> Reviewed-by: Zorro Lang <zlang@redhat.com>
>> ---
> 
> Looks good to me, if no objection or better idea, I'd like change the subject
> as below when I merge it:
>    fstests: batch update of file mode and untracked files

Looks better.


--
Thanks,
Ruan.

> 
> Thanks,
> Zorro
> 
>>   .gitignore        | 2 ++
>>   tests/generic/692 | 0
>>   2 files changed, 2 insertions(+)
>>   mode change 100644 => 100755 tests/generic/692
>>
>> diff --git a/.gitignore b/.gitignore
>> index ad9f45437..a6f433f1d 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -79,6 +79,7 @@ tags
>>   /src/dirstress
>>   /src/e4compact
>>   /src/ext4_resize
>> +/src/fake-dump-rootino
>>   /src/fault
>>   /src/feature
>>   /src/fiemap-tester
>> @@ -205,6 +206,7 @@ tags
>>   /tests/xfs/033.out
>>   /tests/xfs/071.out
>>   /tests/xfs/096.out
>> +/tests/xfs/216.out
>>   
>>   # cscope files
>>   cscope.*
>> diff --git a/tests/generic/692 b/tests/generic/692
>> old mode 100644
>> new mode 100755
>> -- 
>> 2.38.1
>>
> 
