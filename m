Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:43355 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbbCZNcG convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 26 Mar 2015 09:32:06 -0400
Date: Thu, 26 Mar 2015 09:32:02 -0400 (EDT)
From: Jan Tulak <jtulak@redhat.com>
Message-ID: <408615023.3143375.1427376722145.JavaMail.zimbra@redhat.com>
In-Reply-To: <alpine.LFD.2.00.1503251637110.16030@localhost.localdomain>
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com> <1427290055-32647-1-git-send-email-jtulak@redhat.com> <20150325144452.GH20767@twin.jikos.cz> <alpine.LFD.2.00.1503251608001.16030@localhost.localdomain> <497845904.2655152.1427297233349.JavaMail.zimbra@redhat.com> <alpine.LFD.2.00.1503251637110.16030@localhost.localdomain>
Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits only.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: David Sterba <dsterba@suse.cz>, eguan@redhat.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



----- Original Message -----
> From: "Lukáš Czerner" <lczerner@redhat.com>
> To: "Jan Tulak" <jtulak@redhat.com>
> Cc: "David Sterba" <dsterba@suse.cz>, eguan@redhat.com, fstests@vger.kernel.org
> Sent: Wednesday, 25 March, 2015 4:43:22 PM
> Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits only.
> 
> First of all, what's the point of the names if they are the same ?
> And secondly what's the point of numbers if they repeat so often ?
> 
> This is probably only relevant to your performance patches, but can
> you elaborate a bit more on how you plan to name the tests ? Because I am
> not sure the example you've just shown is the best approach.
> 
> Also is there a reason for you to see it grouped by the name when
> you do ls ? It's not like it'll help you run a group of the tests at
> once.
> 
> -Lukas
> 

Rather than in "ls", I thought about seeing them grouped in the group file. But when I thought about it more, I found it pretty much useless for most of cases (as long as the test has all groups it should have). So I'm taking back my objections about it. 
You can call it a small scope creep with groups. :-)

I'm sending a patch with the unique IDs in front of the name.

Jan
