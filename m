Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580ABC3A59D
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Oct 2022 07:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJXHQL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Oct 2022 03:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJXHQK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Oct 2022 03:16:10 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC233F1EC
        for <fstests@vger.kernel.org>; Mon, 24 Oct 2022 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1666595765; i=@fujitsu.com;
        bh=TDyZ+YjyDvVArsaY1ZkGkNQft/YJSMCYYDrn9nWpgxU=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=QSIkSv5g540hOkUSKFeaBnwn/0cnBJ/ZuCmwANLajcqAmI0o4IVjdY/KiuWA9FCW0
         z9RX7zsR7k67SJWyaKpuAAxlMnNvJHMQlUTuKGMMB0SyTeOS8ajVWf3mNnsU+YvKrJ
         s2/nL8uM0fwNI6bO5PPaNbTNWR8EwmGzcP4OAXSjGIpat+jfkkk2epc4BgSAqw9jH5
         G6ijEgbUuFLE917MsUMxnMyZ+w3+PMsZpFbf0jUXOrbssQO3DtUTHm9dA+AV8dmRNX
         P5Wcrqqyc3hhiv/JJlb8f3RHkKlfpQn+gvKjseOitAK02i4dBIZ3RUzAYwy+IXQ8jC
         Fj6rA/RQ/thFQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRWlGSWpSXmKPExsViZ8MxSXerdVi
  ywZNFvBbvPldZXH7CZ3G6ZS+7xd6TO1kdWDw2repk83i/7yqbx+dNcgHMUayZeUn5FQmsGRev
  L2It+MBdcefNMtYGxn+cXYycHEICWxglTk7l62LkArKXM0msed7ADpHYxijxskcBxOYVsJO4+
  P82E4jNIqAq0dswhwkiLihxcuYTFhBbVCBJ4uqGu6wgtrBAiMT2Vw1sILaIgKbEkW/XmEAWMA
  t0MUqcPnqAGWJbG6PE86OzwLaxCThKzJu1EayDU0BD4v+jOWBTmQUsJBa/OcgOYctLNG+dzQx
  iSwgoSrQt+ccOYVdIzJrVxgRhq0lcPbeJeQKj0CwkB85CMmoWklELGJlXMZoXpxaVpRbpGprp
  JRVlpmeU5CZm5uglVukm6qWW6ublF5Vk6BrqJZYX66UWF+sVV+Ym56To5aWWbGIERkdKcSrzD
  sbLy/7oHWKU5GBSEuVlEA9LFuJLyk+pzEgszogvKs1JLT7EKMPBoSTBW6MFlBMsSk1PrUjLzA
  FGKkxagoNHSYR3lhFQmre4IDG3ODMdInWKUVFKnLfTCighAJLIKM2Da4Mlh0uMslLCvIwMDAx
  CPAWpRbmZJajyrxjFORiVhHmPWQJN4cnMK4Gb/gpoMRPQ4ksrgkAWlyQipKQamDpyFgXe33/5
  zL2g95vYZGO2C5V4X9XkLlFsffPOl5Mn8OxeGa9tRa9V3He89TpWtcltqu87U2WNTeZdr+7F1
  E3vcZxXcdRaMO8no9614jirTZHhKgo9SxwTzh9VEg1Y92LR/63Xan/+45a9vK9revdzXeWITx
  s2Xg3MFAr+KHuy1lbRhenPuxfsXptmcl+OOCBruqz7xzuZkNaf1g47tgk3antbrJmlHnzg+N3
  4OS8KOLV2FkmE3uGX3O1XMM+seY5RlqZZ8clVdr/U7MJ1TJslF5omNkVrXOu3aZx1SObZqRth
  m+0mnN+3cdbcKM3Z21YIP1s5ZVl7sUpKYoxyALtUep+W0ZUHdXefSk1oVmIpzkg01GIuKk4EA
  CSHEROJAwAA
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-10.tower-728.messagelabs.com!1666595764!181496!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32711 invoked from network); 24 Oct 2022 07:16:05 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-10.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Oct 2022 07:16:05 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 978FC1000EE;
        Mon, 24 Oct 2022 08:16:04 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 89F111000D2;
        Mon, 24 Oct 2022 08:16:04 +0100 (BST)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 24 Oct 2022 08:16:02 +0100
Message-ID: <ddc1978f-686e-de66-71bf-b39dbafc2a9d@fujitsu.com>
Date:   Mon, 24 Oct 2022 15:15:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND 2/2] generic/470: Replace thin volume with
 blkdiscard -z
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "zlang@redhat.com" <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>
References: <20221023064810.847110-1-yangx.jy@fujitsu.com>
 <20221023064810.847110-2-yangx.jy@fujitsu.com> <Y1YP7ehSZUdVS4/J@magnolia>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <Y1YP7ehSZUdVS4/J@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/10/24 12:09, Darrick J. Wong wrote:
> On Sun, Oct 23, 2022 at 06:48:13AM +0000,yangx.jy@fujitsu.com  wrote:
>> generic/470 was original designed to verify mmap(MAP_SYNC) which
>> is only vaild to the DAX capable device(e.g. PMEM). Thin volume[1] was
>> introduced to fix the inconsistent filesystem issue[2] but it make
>> the test become not run because it doesn't support DAX. As Darrick
>> mentioned[3], discarding the entire mapped range of scartch device
>> can fix the issue as well, so I try to use blkdiscard -z instead.
> That might be ok for the*other*  dm-logwrites tests, but isn't the
> fundamental problem here (generic/470, specifically) that device mapper
> cannot run on top of pmem?

Hi Darrick,

With the change，I didn't find any failure when running generic/470 in 
loops.
--------------------------------------------------------------
[root@fedora35 xfstests-dev]# ./check generic/470
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 fedora35 6.1.0-rc1+ #37 SMP 
PREEMPT_DYNAMIC Fri Oct 21 19:04:57 CST 2022
MKFS_OPTIONS  -- -f /dev/pmem0
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/pmem0 
/mnt/scratch

generic/470 6s
Ran: generic/470
Passed all 1 tests
--------------------------------------------------------------
Both dm-log-writes and PMEM support DAX so it's fine to verify 
mmap(MAP_SYNC) with the dm-log-writes device on top of PMEM.

Did I miss something? Why do you think there is a fundamental problem here?

Best Regards,
Xiao Yang

> 
> --D
> 
