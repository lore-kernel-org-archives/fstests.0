Received: from mail-vk0-f54.google.com ([209.85.213.54]:34924 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbcGTSzu (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2016 14:55:50 -0400
Received: by mail-vk0-f54.google.com with SMTP id w127so81925273vkh.2
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2016 11:55:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADxRZqx_=YocT+O3cWVMTQD+Gk7-=ev9t0nXWSUx1WT1=WsPiQ@mail.gmail.com>
References: <CADxRZqxz7XJ43i_Mn8kdnP7KPR2sK1wK5T2B-QAYj9_jCqUbCg@mail.gmail.com>
 <CADxRZqym3LQa0czmO0Ni5+qQ6R=U7s_7A7H9YWDeVcz8UtGqrg@mail.gmail.com>
 <20160719103154.GQ27776@eguan.usersys.redhat.com> <CADxRZqx_=YocT+O3cWVMTQD+Gk7-=ev9t0nXWSUx1WT1=WsPiQ@mail.gmail.com>
From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 20 Jul 2016 21:55:48 +0300
Message-ID: <CADxRZqwSf4QhzZUKr1Jrdnis3D+eA=BUAfMWZbTi2QVcc2=riA@mail.gmail.com>
Subject: Re: Fwd: xfstests: error: redefinition of 'struct fsxattr'
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 19, 2016 at 3:38 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
> On Tue, Jul 19, 2016 at 1:31 PM, Eryu Guan <eguan@redhat.com> wrote:
>> On Tue, Jul 19, 2016 at 01:24:53PM +0300, Anatoly Pugachev wrote:
>>> Hello!
>>>
>>> Can someone help me to compile xfstests taken from
>>> git://oss.sgi.com/xfs/cmds/xfstests
>>
>> This should have been fixed in latest xfstests. Does your tree contain
>> commit ca7c8bcbe851 ("build: avoid struct fsxattr redefinition")?
>
> Eryu,
>
> my current HEAD is at 024bdae (as seen in the output of git describe) :
>
> mator@windrunner:~/xfstests$ git describe
> linux-v3.8-1104-g024bdae
>
> i'm running debian sid with 4.6.3 kernel installed :

solved. debian have old xfsprogs 4.3.0 , if i install 4.5.0 manually,
it does compiles ok.
thanks.
