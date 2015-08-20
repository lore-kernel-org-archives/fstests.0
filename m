Received: from mail-lb0-f180.google.com ([209.85.217.180]:36624 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbbHTVR4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 20 Aug 2015 17:17:56 -0400
Received: by lbbpu9 with SMTP id pu9so32059924lbb.3
        for <fstests@vger.kernel.org>; Thu, 20 Aug 2015 14:17:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150820210812.GO3902@dastard>
References: <55D52473.7050209@cn.fujitsu.com>
	<1440032464-17626-1-git-send-email-yangds.fnst@cn.fujitsu.com>
	<CAHpGcMLZT5xYx5EUBLTPyLQd0f+jQ-g+c_f-oErsHP33m7-ROg@mail.gmail.com>
	<20150820210812.GO3902@dastard>
Date: Thu, 20 Aug 2015 23:17:54 +0200
Message-ID: <CAHpGcM+-dqBNQKE0bxeF+bM1Gb11NmXiy-jjb-pj-_ziSyKL0g@mail.gmail.com>
Subject: Re: [PATCH] fstests: link .out to correct output when we set USE_ATTR_SECURE=yes
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>, fstests@vger.kernel.org, linux-mtd@lists.infradead.org, richard.weinberger@gmail.com
List-ID: <fstests@vger.kernel.org>

2015-08-20 23:08 GMT+02:00 Dave Chinner <david@fromorbit.com>:
> The correct way to do this [...]

Yes, that's better.

Thanks,
Andreas
