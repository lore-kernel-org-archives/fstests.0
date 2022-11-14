Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900ADC433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Nov 2022 08:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbiKNIix (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Nov 2022 03:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbiKNIiw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Nov 2022 03:38:52 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8450A5585
        for <fstests@vger.kernel.org>; Mon, 14 Nov 2022 00:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668415129; i=@fujitsu.com;
        bh=VCKR7SEvvv65rpOmkx3wrhlV6/zcp0egY+25afCaStE=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=Z5aID2Z8uj37HDdzX9T+TiBaVoWeFjMbnftqf29blOQ8qRar7UwtD5jsEMAN00Km8
         RKGaNGAJ2AmfrmtMbLXOPcCpNSXPcEf9fkJ9MS0zxY1XGaxiO+rwhvBGFfcMicwd4E
         0Z5O68WVbp+N0rmwt18HNJ91YAJyuiJzAMlhQBsMCjXMrN/LmSSgZsVuyVY/RCYBV0
         2PBS1OsywydQEJx4/0xWXc38xACu7+05RVPZcarkbiddIjTAYu8Vw/uEino1o8jU5t
         NwkJxfIElE5fI3xfFA7fuu/0BUZ5Nmc4f6zCXV5KW+TnPMOhIk67N8pLJ+0Km0Ob6W
         btlep6nVErahg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRWlGSWpSXmKPExsViZ8ORpDvzX2G
  ywa83chbvPldZXH7CZ3G6ZS+7xd6TO1kdWDw2repk83i/7yqbx+dNcgHMUayZeUn5FQmsGe8W
  r2Ip2Mha8fNZE3MD4zGWLkYuDiGBjYwSW/50MUM4S5gkfvx5wQ7hbGOUePz0OlMXIycHr4Cdx
  NcNk8BsFgFViebFq9kg4oISJ2c+YQGxRQWSJK5uuMsKYgsLhEhsf9UAViMioClx5Ns1JpChzA
  J7GCV6H6xkhNjQxijR8+I3I0gVm4CjxLxZG8E6OAU0JC71vgXbxixgIbH4zUF2CFteYvvbOcw
  gtoSAokTbkn/sEHaFxKxZbUwQtprE1XObmCcwCs1CcuAsJKNmIRm1gJF5FaNpcWpRWWqRrple
  UlFmekZJbmJmjl5ilW6iXmqpbnlqcYmuoV5iebFeanGxXnFlbnJOil5easkmRmB0pBSzF+xgn
  Lnsj94hRkkOJiVR3st/CpOF+JLyUyozEosz4otKc1KLDzHKcHAoSfB6geQEi1LTUyvSMnOAkQ
  qTluDgURLhVf4JlOYtLkjMLc5Mh0idYlSUEufN/AuUEABJZJTmwbXBksMlRlkpYV5GBgYGIZ6
  C1KLczBJU+VeM4hyMSsK8QsBUI8STmVcCN/0V0GImoMXfI/NAFpckIqSkGpiW2vHnet7dp7Pw
  cfyv8JcbOTk+Rp1W1rxmP3Hy3rRk4WUNBYm9n3zaT2Ydl19Qo9HJKH2gfuf2aAOxBbaN9z/Zd
  YhVdtRslTKdtbBAyfDc9NJp5q2evz9Fp4Vv54iOnXKLb3G5uHdLgjFvyGSn4Eo11jMRC45O+d
  +383WjUva6P2I+C56VX953f9IiraD6yiX3fLKC+X1kVOTKqlInaWbc/XdGL5mrKlzOPOucQ0O
  85981XDE/bvxsWFa86tbiok6vsp7Pu1Ni+MpTfu6J2OVgtH2eG8/+Q9OEEqJNHk9inFjlGLd7
  hR8TY8/J1IaXsySU1PiTk4TXpRvyK0rqeBfxddyaxafHctFWoneSEktxRqKhFnNRcSIAYbd+1
  IkDAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-6.tower-585.messagelabs.com!1668415129!192905!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8000 invoked from network); 14 Nov 2022 08:38:49 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-6.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Nov 2022 08:38:49 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 1C2241AF;
        Mon, 14 Nov 2022 08:38:49 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 10C861AD;
        Mon, 14 Nov 2022 08:38:49 +0000 (GMT)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 14 Nov 2022 08:38:46 +0000
Message-ID: <f45be313-a1a6-7f1a-9289-3a7d95c78551@fujitsu.com>
Date:   Mon, 14 Nov 2022 16:38:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND 2/2] generic/470: Replace thin volume with
 blkdiscard -z
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "zlang@redhat.com" <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
References: <20221023064810.847110-1-yangx.jy@fujitsu.com>
 <20221023064810.847110-2-yangx.jy@fujitsu.com> <Y3EwIvDfZdIlzHKg@magnolia>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <Y3EwIvDfZdIlzHKg@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/11/14 1:57, Darrick J. Wong wrote:
> You used -z, which means the comment should say "Forcibly zero the
> mapped range of the scratch device..." and note that blkdiscard -z will
> fall back to writing buffers of zeroes if the device doesn't support
> WRITE SAME with zeroes.
> 
> I think the logic in here looks good though.
> 
> --D

Hi Darrick,

Thanks a lot for your comment.
I have sent the v2 patch set[1][2] as you suggested. I hope you can 
review them again.

[1] 
https://lore.kernel.org/fstests/1668414903-13-1-git-send-email-yangx.jy@fujitsu.com/T/#t
[2] 
https://lore.kernel.org/fstests/1668414903-13-2-git-send-email-yangx.jy@fujitsu.com/T/#u

Best Regards,
Xiao Yang
