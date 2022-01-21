Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0A0C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 21 Jan 2022 11:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245468AbiAUL5H (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:57:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233354AbiAUL5G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Jan 2022 06:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642766225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=9uZUpsMApXfUGRKNr04C2LXHbJMcKPYyutvQE6ZEilU=;
        b=IvVBcNHduJ5+V9wFHEOY0Z2IfT6wKBU2Cluh9+2ar/EffULpgl6EVtil58PZiM83foGGHr
        17B5bwnP7dxJf87PirzK6X9dLfKEfRVXhrtTCOpwOSgSUwUiZAjFXySwS0w2F0Z9LkJw/R
        94ETyL5KQqyyFSpiBWCX5rLIGX75M14=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-XoDb9Hg1Mj2bQThtyjbSFA-1; Fri, 21 Jan 2022 06:57:03 -0500
X-MC-Unique: XoDb9Hg1Mj2bQThtyjbSFA-1
Received: by mail-lf1-f72.google.com with SMTP id e15-20020a05651236cf00b00435bdd5b67eso2413319lfs.12
        for <fstests@vger.kernel.org>; Fri, 21 Jan 2022 03:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9uZUpsMApXfUGRKNr04C2LXHbJMcKPYyutvQE6ZEilU=;
        b=KgHiwpp0+PVeocYpiof5n1eBRU8gHq19pezTjfJmkC2GSn7nQCTMapoiM85Q4zSVPs
         qqZYphhctYk3/QnA/n83PXEZvTOGFRQV8lw5DEDTrMXdgHMpoPSgisoOSUSDcDcnXZMz
         4nHGr2xbt+VLcqmOsFc87H8CHkjHlIiiJJKCZseS973R649YJzkXr+cqCDBpcI7kB8A8
         4n/B2h3To5KVCfuGMf2ZqFg3yx684S33MLuCzl8N0/qfB+M4/rfq6VhO+nDx6KuCQKL7
         zlswnyoS+5Cn9zD1iPrypF2zZaRGzfkVHzRCm3RDkYbxouQxWA7hXCD7Zh5J1rAhLzgP
         JLzA==
X-Gm-Message-State: AOAM531Va9uaHrnzbcQOgjMLZOjSfBAaL92jFY0xyOIB1VZdid0eg/s0
        qxtSGr0/1IYjK5ZUf+jzADwft7rpIgryB1Icg8xyOm2qQTutRNPClyZkEpAT6IN4UkTCpicw8e1
        YdATcdHjQ1ITXlT4dZJO6VNiSYT7u3XMM2Q==
X-Received: by 2002:a05:651c:4c8:: with SMTP id e8mr2816459lji.29.1642766221853;
        Fri, 21 Jan 2022 03:57:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxS/Wf7lvMQhEJMwtmBdv1otjGJU7JCU3NC+Lz8wEp/b/wYnoXa9gXEATfdjLV1I03sNvugaq9DAxej2xnrWys=
X-Received: by 2002:a05:651c:4c8:: with SMTP id e8mr2816449lji.29.1642766221629;
 Fri, 21 Jan 2022 03:57:01 -0800 (PST)
MIME-Version: 1.0
From:   Rishabh Dave <ridave@redhat.com>
Date:   Fri, 21 Jan 2022 17:26:50 +0530
Message-ID: <CA+jMu4Q5cx5+G7jtrNT3RL8gi6nUB6ZikP1ztFUjTQUh6ojLrA@mail.gmail.com>
Subject: adding support for ceph-fuse
To:     fstests@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001706af05d61651b3"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

--0000000000001706af05d61651b3
Content-Type: text/plain; charset="UTF-8"

Hi,

Currently tests from xfstests-dev can be executed against CephFS
mounted using the kernel but not mounted using FUSE. This is so
because right now xfstests-dev doesn't know how to mount CephFS with
FUSE.

I've written a patch (attached to this e-mail) that adds the ability
to xfstests-dev to mount CephFS with FUSE as well. I've tested the
patch against Ceph's master branch. The patch works fine IMO because
after applying the patch I could run tests against kernel-mounted as
well as FUSE-mounted CephFS.

I am not sure about the review process for xfstests-dev, please let me
know if the patches need to be uploaded elsewhere. Thanks in advance.

Regards,
- Rishabh

--0000000000001706af05d61651b3
Content-Type: text/x-patch; charset="US-ASCII"; name="add-ceph-fuse-support-final.patch"
Content-Disposition: attachment; 
	filename="add-ceph-fuse-support-final.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kyocd2f00>
X-Attachment-Id: f_kyocd2f00

ZGlmZiAtLWdpdCBhL2NvbW1vbi9jb25maWcgYi9jb21tb24vY29uZmlnCmluZGV4IGUwYTVjNWRm
Li4xODZlMGU5YSAxMDA2NDQKLS0tIGEvY29tbW9uL2NvbmZpZworKysgYi9jb21tb24vY29uZmln
CkBAIC01NDcsNiArNTQ3LDggQEAgX2NoZWNrX2RldmljZSgpCiAJCQlfZmF0YWwgImNvbW1vbi9j
b25maWc6ICRuYW1lICgkZGV2KSBpcyBub3QgYSBjaGFyYWN0ZXIgZGV2aWNlIgogCQlmaQogCQk7
OworCWNlcGgtZnVzZSkKKwkJOzsKIAkqKQogCQlfZmF0YWwgImNvbW1vbi9jb25maWc6ICRuYW1l
ICgkZGV2KSBpcyBub3QgYSBibG9jayBkZXZpY2Ugb3IgYSBuZXR3b3JrIGZpbGVzeXN0ZW0iCiAJ
ZXNhYwpkaWZmIC0tZ2l0IGEvY29tbW9uL3JjIGIvY29tbW9uL3JjCmluZGV4IDc5NzNjZWI1Li5h
NTg5MzVhZiAxMDA2NDQKLS0tIGEvY29tbW9uL3JjCisrKyBiL2NvbW1vbi9yYwpAQCAtNDQ2LDEw
ICs0NDYsMTQgQEAgX3NjcmF0Y2hfc2h1dGRvd25faGFuZGxlKCkKIAogX3Rlc3RfbW91bnQoKQog
ewotICAgIGlmIFsgIiRGU1RZUCIgPT0gIm92ZXJsYXkiIF07IHRoZW4KKyAgICBpZiBbICIkRlNU
WVAiID09ICJjZXBoLWZ1c2UiIF07IHRoZW4KKyAgICAgICAgJENFUEhfRlVTRV9CSU5fUEFUSCAk
VEVTVF9GU19NT1VOVF9PUFRTICRURVNUX0RJUiAyPiAvZGV2L251bGwKKyAgICAgICAgcmV0dXJu
ICQ/CisgICAgZWxpZiBbICIkRlNUWVAiID09ICJvdmVybGF5IiBdOyB0aGVuCiAgICAgICAgIF9v
dmVybGF5X3Rlc3RfbW91bnQgJCoKICAgICAgICAgcmV0dXJuICQ/CiAgICAgZmkKKwogICAgIF90
ZXN0X29wdGlvbnMgbW91bnQKICAgICBfbW91bnQgLXQgJEZTVFlQICRURVNUX09QVElPTlMgJFRF
U1RfRlNfTU9VTlRfT1BUUyAkU0VMSU5VWF9NT1VOVF9PUFRJT05TICQqICRURVNUX0RFViAkVEVT
VF9ESVIKIH0KQEAgLTEzODYsNyArMTM5MCw4IEBAIF9mc190eXBlKCkKICAgICAjIGhhdmUgdG8g
Ym90aGVyIHdpdGggdGhpcyBxdWlyay4KICAgICAjCiAgICAgX2RmX2RldmljZSAkMSB8ICRBV0tf
UFJPRyAneyBwcmludCAkMiB9JyB8IFwKLSAgICAgICAgc2VkIC1lICdzL25mczQvbmZzLycgLWUg
J3MvZnVzZS5nbHVzdGVyZnMvZ2x1c3RlcmZzLycKKyAgICAgICAgc2VkIC1lICdzL25mczQvbmZz
LycgLWUgJ3MvZnVzZS5nbHVzdGVyZnMvZ2x1c3RlcmZzLycgXAorICAgICAgICAgICAgLWUgJ3Mv
ZnVzZS5jZXBoLWZ1c2UvY2VwaC1mdXNlLycKIH0KIAogIyByZXR1cm4gdGhlIEZTIG1vdW50IG9w
dGlvbnMgb2YgYSBtb3VudGVkIGRldmljZQpAQCAtMTUzNSw2ICsxNTQwLDI0IEBAIF9zdXBwb3J0
ZWRfZnMoKQogICAgIF9ub3RydW4gIm5vdCBzdWl0YWJsZSBmb3IgdGhpcyBmaWxlc3lzdGVtIHR5
cGU6ICRGU1RZUCIKIH0KIAorX2NoZWNrX2lmX2Rldl9hbHJlYWR5X21vdW50ZWQoKQoreworCWxv
Y2FsIGRldj0kMQorCWxvY2FsIG1udD0kMgorCisJIyBmaW5kICRkZXYgYXMgdGhlIHNvdXJjZSwg
YW5kIHByaW50IHJlc3VsdCBpbiAiJGRldiAkbW50IiBmb3JtYXQKKwlsb2NhbCBtb3VudF9yZWM9
YGZpbmRtbnQgLXJuY3YgLVMgJGRldiAtbyBTT1VSQ0UsVEFSR0VUYAorCVsgLW4gIiRtb3VudF9y
ZWMiIF0gfHwgcmV0dXJuIDEgIyAxID0gbm90IG1vdW50ZWQKKworCSMgaWYgaXQncyBtb3VudGVk
LCBtYWtlIHN1cmUgaXRzIG9uICRtbnQKKwlpZiBbICIkbW91bnRfcmVjIiAhPSAiJGRldiAkbW50
IiBdOyB0aGVuCisJCWVjaG8gIiRkZXZuYW1lPSRkZXYgaXMgbW91bnRlZCBidXQgbm90IG9uICRt
bnRuYW1lPSRtbnQgLSBhYm9ydGluZyIKKwkJZWNobyAiQWxyZWFkeSBtb3VudGVkIHJlc3VsdDoi
CisJCWVjaG8gJG1vdW50X3JlYworCQlyZXR1cm4gMiAjIDIgPSBtb3VudGVkIG9uIHdyb25nIG1u
dAorCWZpCit9CisKICMgY2hlY2sgaWYgYSBGUyBvbiBhIGRldmljZSBpcyBtb3VudGVkCiAjIGlm
IHNvLCB2ZXJpZnkgdGhhdCBpdCBpcyBtb3VudGVkIG9uIG1vdW50IHBvaW50CiAjIGlmIGZzdHlw
ZSBpcyBnaXZlbiBhcyBhcmd1bWVudCwgdmVyaWZ5IHRoYXQgaXQgaXMgYWxzbwpAQCAtMTU0OCwx
NiArMTU3MSwxNCBAQCBfY2hlY2tfbW91bnRlZF9vbigpCiAJbG9jYWwgbW50PSQ0CiAJbG9jYWwg
dHlwZT0kNQogCi0JIyBmaW5kICRkZXYgYXMgdGhlIHNvdXJjZSwgYW5kIHByaW50IHJlc3VsdCBp
biAiJGRldiAkbW50IiBmb3JtYXQKLQlsb2NhbCBtb3VudF9yZWM9YGZpbmRtbnQgLXJuY3YgLVMg
JGRldiAtbyBTT1VSQ0UsVEFSR0VUYAotCVsgLW4gIiRtb3VudF9yZWMiIF0gfHwgcmV0dXJuIDEg
IyAxID0gbm90IG1vdW50ZWQKKwkjIHRoaXMgY2hlY2sgZG9lc24ndCB3b3JrIG9uIGNlcGgtZnVz
ZQorCWlmIFsgIiRkZXYiICE9ICJjZXBoLWZ1c2UiIF07IHRoZW4KKwkJX2NoZWNrX2lmX2Rldl9h
bHJlYWR5X21vdW50ZWQgJGRldiAkbW50CisJCWRldl9hbHJlYWR5X21vdW50ZWQ9JD8KIAotCSMg
aWYgaXQncyBtb3VudGVkLCBtYWtlIHN1cmUgaXRzIG9uICRtbnQKLQlpZiBbICIkbW91bnRfcmVj
IiAhPSAiJGRldiAkbW50IiBdOyB0aGVuCi0JCWVjaG8gIiRkZXZuYW1lPSRkZXYgaXMgbW91bnRl
ZCBidXQgbm90IG9uICRtbnRuYW1lPSRtbnQgLSBhYm9ydGluZyIKLQkJZWNobyAiQWxyZWFkeSBt
b3VudGVkIHJlc3VsdDoiCi0JCWVjaG8gJG1vdW50X3JlYwotCQlyZXR1cm4gMiAjIDIgPSBtb3Vu
dGVkIG9uIHdyb25nIG1udAorCQlpZiBbICRkZXZfYWxyZWFkeV9tb3VudGVkIC1uZSAwIF07IHRo
ZW4KKwkJCXJldHVybiAkZGV2X2FscmVhZHlfbW91bnRlZAorCQlmaQogCWZpCiAKIAlpZiBbIC1u
ICIkdHlwZSIgLWEgImBfZnNfdHlwZSAkZGV2YCIgIT0gIiR0eXBlIiBdOyB0aGVuCkBAIC0xNzc5
LDYgKzE4MDAsOCBAQCBfcmVxdWlyZV90ZXN0KCkKIAkJCV9ub3RydW4gInRoaXMgdGVzdCByZXF1
aXJlcyBhIHZhbGlkIFwkVEVTVF9ESVIiCiAJCWZpCiAJCTs7CisJY2VwaC1mdXNlKQorCQk7Owog
CWNpZnMpCiAJCWVjaG8gJFRFU1RfREVWIHwgZ3JlcCAtcSAiLy8iID4gL2Rldi9udWxsIDI+JjEK
IAkJaWYgWyAteiAiJFRFU1RfREVWIiAtbyAiJD8iICE9ICIwIiBdOyB0aGVuCkBAIC0zMTEyLDcg
KzMxMzUsNyBAQCBfY2hlY2tfdGVzdF9mcygpCiAgICAgdmlydGlvZnMpCiAJIyBubyB3YXkgdG8g
Y2hlY2sgY29uc2lzdGVuY3kgZm9yIHZpcnRpb2ZzCiAJOzsKLSAgICBjZXBoKQorICAgIGNlcGh8
Y2VwaC1mdXNlKQogCSMgbm8gd2F5IHRvIGNoZWNrIGNvbnNpc3RlbmN5IGZvciBDZXBoRlMKIAk7
OwogICAgIGdsdXN0ZXJmcykK
--0000000000001706af05d61651b3--

