Received: from cn.fujitsu.com ([222.73.24.84]:38707 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751615AbdGaDtp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 30 Jul 2017 23:49:45 -0400
Message-ID: <597EA643.3020905@cn.fujitsu.com>
Date: Mon, 31 Jul 2017 11:38:43 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic/449: remove unused _require_test
References: <1500879458-3673-1-git-send-email-yangx.jy@cn.fujitsu.com> <20170730032727.GA4836@debian.home>
In-Reply-To: <20170730032727.GA4836@debian.home>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?=22Ernesto_A=2E_Fern=E1ndez=22?= <ernesto.mnd.fernandez@gmail.com>
Cc: fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On 2017/07/30 11:27, Ernesto A. Fern=E1ndez wrote:
> On Mon, Jul 24, 2017 at 02:57:38PM +0800, Xiao Yang wrote:
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>   _supported_fs generic
>>   _supported_os Linux
>>   _require_scratch
>> -_require_test
>>   _require_acls
>>   _require_attrs
> Hi, I wrote that test, thank you for taking the time to review it.
>
> It would seem that _require_acls uses the test device, things could get
> weird if it's not there.
>
>
Hi Ernesto A and Eryu,

init_rc() have checked if TEST_DEV existed and was mounted, and we=20
introduced _require_test to check
file system consistency on TEST_DEV after running tests.   I think it's=20
not necessary to add _require_test.

I'm not sure about it, so cc Eryu to confirm it.

Thanks,
Xiao Yang.



