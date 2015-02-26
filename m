Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49833 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753559AbbBZLlN (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 26 Feb 2015 06:41:13 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1QBfCIJ013211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 26 Feb 2015 06:41:12 -0500
Message-ID: <54EF0656.6030206@fedoraproject.org>
Date: Thu, 26 Feb 2015 11:41:10 +0000
From: Andrew Price <andyp@fedoraproject.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] xfstests: fix a typo in _require_block_device()
References: <1424069440-14957-1-git-send-email-zhaolei@cn.fujitsu.com> <20150218012139.GO4251@dastard> <54E4679C.7030309@fedoraproject.org> <20150218220204.GP12722@dastard> <alpine.LFD.2.00.1502261049520.25704@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.1502261049520.25704@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: =?windows-1252?Q?Luk=E1=9A_Czerner?= <lczerner@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


>>>> The change is fine - the reformating of the code is not. 8 space
>>>> tabs
>>>
>>> To be clear, do you mean 8 spaces or single tabs?
>>
>> Single tab, but tabs are the width of 8 spaces. Same as you'd use
>> for writing new kernel code.
>
> Even I was confused by that :) Just use tabs not spaces. Width of the
> tab is whatever your editor decides it is

Exactly :)

> so it's irrelevant :)

Well, unfortunately many use tabs for alignment as well as indentation 
so changing the width of a tab can make code look ugly where there are 
line continuations, aligned comments, etc. Using tabs for indentation 
and spaces for alignment is ideal, but tabs-for-alignment is so common 
that assuming tabs are always displayed 8 characters wide is often the 
pragmatic option.

Andy
